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
    
    // Email Register
    func registerUser(with userRequest: RegisterUserRequest,completion: @escaping (Bool, Error?) -> Void) {
        auth.createUser(withEmail: userRequest.email, password: userRequest.password) { [weak self] result, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let user = result?.user else {
                completion(false, nil)
                return
            }
            
            let data: [String: Any] = [
                "username": userRequest.username,
                "email": user.email ?? "",
                "phone": user.phoneNumber ?? "",
                "createdAt": FieldValue.serverTimestamp()
            ]
            
            self?.db.collection("users")
                .document(user.uid)
                .setData(data, merge: true) { error in
                    completion(error == nil, error)
                }
        }
    }
    func updateUserProfile(email:String,username: String, lastName: String, birthDate: Date, completion: @escaping (Bool, Error?) -> Void) {
        guard let uid = auth.currentUser?.uid else {
            completion(false, NSError(domain: "AuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"]))
            return
        }
        
        let data: [String: Any] = [
            "email": email,
            "username": username,
            "lastName": lastName,
            "birthDate": Timestamp(date: birthDate),
            "updatedAt": FieldValue.serverTimestamp()
        ]
        
        db.collection("users")
            .document(uid)
            .setData(data, merge: true) { error in
                completion(error == nil, error)
            }
    }
    //სექმნა ბარათის და შენახვა ფაირბეისშ Create CArd 
    func createCard(cardNumber:String,cardHolder:String,expireDate:String,cvv:String, completion: @escaping (Bool, Error?)-> Void) {
        guard let uid = auth.currentUser?.uid else {
            completion(false, NSError(domain: "AuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"]))
            return
        }
        
        let data: [String: Any] = [
            "cardNumber": cardNumber,
            "cardHolder": cardHolder,
            "expireDate": expireDate,
            "cvv": cvv,
            "updatedAt": FieldValue.serverTimestamp()
        ]
        
        db.collection("users")
            .document(uid)
            .setData(data, merge: true) { error in
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
                print("❌ verifyCode error:", error.localizedDescription)
                completion(false)
                return
            }
            
            guard let self = self, let user = result?.user else {
                completion(false)
                return
            }
            
            let data: [String: Any] = [
                "phone": self.currentPhoneNumber ?? "",
                "email": user.email ?? "",
                "updatedAt": FieldValue.serverTimestamp()
            ]
            
            self.db.collection("users")
                .document(user.uid)
                .setData(data, merge: true) { error in
                    if let error = error {
                        print("❌ Firestore save error:", error.localizedDescription)
                        completion(false)
                    } else {
                        completion(true)
                    }
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
}
