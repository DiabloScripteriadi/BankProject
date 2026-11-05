//
//  AuthService.swift
//  BNK
//
//  Created by chasemedkcorto on 16.01.26.
//
import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthService {
    
    static let shared = AuthService()
    private init() {}
    
    public let auth = Auth.auth()
    private let db = Firestore.firestore()
    private var verificationId: String?
    private var currentPhoneNumber: String?
    func registerUser(
        with userRequest: RegisterUserRequest,
        firstName: String,
        lastName: String,
        birthDate: Date,
        completion: @escaping (Bool, Error?) -> Void
    ) {
        auth.createUser(withEmail: userRequest.email, password: userRequest.password) { [weak self] result, error in
            if let error = error {
                completion(false, error)
                return
            }

            guard let self = self, let user = result?.user else {
                completion(false, nil)
                return
            }

            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = "\(firstName) \(lastName)"

            changeRequest.commitChanges { error in
                if let error = error {
                    completion(false, error)
                    return
                }

                let data: [String: Any] = [
                    "uid": user.uid,
                    "username": userRequest.username,
                    "firstName": firstName,
                    "lastName": lastName,
                    "birthDate": Timestamp(date: birthDate),
                    "email": user.email ?? "",
                    "phone": userRequest.phone,
                    "createdAt": FieldValue.serverTimestamp(),
                    "updatedAt": FieldValue.serverTimestamp(),
                    "account": [
                        "accountNumber": UUID().uuidString,
                        "balance": 0,
                        "currency": "GEL"
                    ]
                ]

                self.db.collection("users")
                    .document(user.uid)
                    .setData(data, merge: true) { error in
                        if let error = error {
                            print("❌ Firestore Write Error: \(error.localizedDescription)")
                            completion(false, error)
                        } else {
                            print("✅ User registered and profile saved!")
                            completion(true, nil)
                        }
                    }
            }
        }
    }

    func createCardSecurely(last4: String, brand: String, paymentMethodId: String, completion: @escaping (Bool, Error?) -> Void) {
        guard let uid = auth.currentUser?.uid else {
            let err = NSError(domain: "AuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"])
            completion(false, err)
            return
        }
        
        let data: [String: Any] = [
            "last4": last4,
            "brand": brand,
            "paymentMethodId": paymentMethodId,
            "updatedAt": FieldValue.serverTimestamp()
        ]
        
        db.collection("users")
            .document(uid)
            .collection("cards")
            .addDocument(data: data) { error in
                completion(error == nil, error)
            }
    }
    
    // Phone Auth (Start)
    func startAuth(phoneNumber: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationID, error in
                self?.currentPhoneNumber = phoneNumber
                if let error = error {
                    print("❌ startAuth error:", error.localizedDescription)
                    completion(false)
                    return
                }
                guard let verificationID = verificationID else {
                    completion(false)
                    return
                }
                self?.verificationId = verificationID
                completion(true)
            }
    }
    
    // Phone Auth (Verify Code)
    func verifyCode(smsCode: String, completion: @escaping (Bool) -> Void) {
        guard let verificationId = verificationId else {
            completion(false)
            return
        }
        
        let credential = PhoneAuthProvider.provider()
            .credential(withVerificationID: verificationId, verificationCode: smsCode)
        
        auth.signIn(with: credential) { [weak self] result, error in
            if let error = error {
                completion(false)
                return
            }
            
            guard let self = self, let user = result?.user else {
                completion(false)
                return
            }
            
            let data: [String: Any] = [
                "phone": self.currentPhoneNumber ?? "",
                "updatedAt": FieldValue.serverTimestamp()
            ]
            
            self.db.collection("users")
                .document(user.uid)
                .setData(data, merge: true) { error in
                    completion(error == nil)
                }
        }
    }
    
    // Transactions
    func addTransaction(senderId: String, receiverId: String, amount: Double, completion: @escaping (Result<String, Error>) -> Void) {
        let data: [String: Any] = [
            "formerUserId": senderId,
            "toUserId": receiverId,
            "amount": amount,
            "createdAt": Timestamp(date: Date())
        ]
        
        var ref: DocumentReference?
        ref = db.collection("transactions").addDocument(data: data) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(ref?.documentID ?? ""))
            }
        }
    }

    // Email Sign In
    func signIn(with userRequest: LoginUSerRequest, completion: @escaping (Error?) -> Void) {
        auth.signIn(withEmail: userRequest.email, password: userRequest.password) { _, error in
            completion(error)
        }
    }
    
    // Sign Out
    func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try auth.signOut()
            completion(nil)
        } catch {
            completion(error)
        }
    }


    func addBalanceListener(callback: @escaping (Int) -> Void) -> ListenerRegistration? {
        guard let uid = auth.currentUser?.uid else { return nil }
        let docRef = db.collection("users").document(uid)
        let listener = docRef.addSnapshotListener { snapshot, error in
            if let error = error {
                print("❌ Balance listener error: \(error.localizedDescription)")
                return
            }
            guard let data = snapshot?.data() else { return }
            // ველი: account.balance როგორც Int
            if let account = data["account"] as? [String: Any],
               let balance = account["balance"] as? Int {
                callback(balance)
            }
        }
        return listener
    }


    func setBalance(to newValue: Int, completion: @escaping (Error?) -> Void) {
        guard let uid = auth.currentUser?.uid else {
            completion(NSError(domain: "AuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"]))
            return
        }
        let docRef = db.collection("users").document(uid)
        docRef.setData([
            "account": [
                "balance": newValue,
                "updatedAt": FieldValue.serverTimestamp()
            ]
        ], merge: true) { error in
            completion(error)
        }
    }

    func updateBalance(delta: Int, completion: @escaping (Error?) -> Void) {
        guard let uid = auth.currentUser?.uid else {
            completion(NSError(domain: "AuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"]))
            return
        }
        let docRef = db.collection("users").document(uid)
        db.runTransaction({ (transaction, errorPointer) -> Any? in
            let snapshot: DocumentSnapshot
            do {
                snapshot = try transaction.getDocument(docRef)
            } catch let fetchError as NSError {
                errorPointer?.pointee = fetchError
                return nil
            }

            var account = snapshot.data()?["account"] as? [String: Any] ?? [:]
            let current = account["balance"] as? Int ?? 0
            let updated = current + delta
            account["balance"] = updated
            account["updatedAt"] = FieldValue.serverTimestamp()

            transaction.setData(["account": account], forDocument: docRef, merge: true)
            return nil
        }, completion: { (_, error) in
            completion(error)
        })
    }
}

