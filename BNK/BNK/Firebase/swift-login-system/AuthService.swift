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
    private var verificationId: String?
    private let auth = Auth.auth()

    //  - Email Register
    func registerUser(with userRequest: RegisterUserRequest, completion: @escaping (Bool, Error?) -> Void) {
        auth.createUser(withEmail: userRequest.email, password: userRequest.password) { result, error in
            if let error = error {
                completion(false, error)
                return
            }
            guard let user = result?.user else {
                completion(false, nil)
                return
            }

            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData([
                    "username": userRequest.username,
                    "email": userRequest.email
                ]) { error in
                    completion(error == nil, error)
                }
        }
    }

    //Phone Auth: Start verification
    func startAuth(phoneNumber: String, completion: @escaping (Bool) -> Void) {
        // Disable App Check / reCAPTCHA for simulator testing
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true

        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationID, error in
            if let error = error {
                print("❌ startAuth error:", error.localizedDescription)
                completion(false)
                return
            }

            guard let verificationID = verificationID else {
                print("❌ No verificationID returned")
                completion(false)
                return
            }

            self?.verificationId = verificationID
            print("✅ verificationID received:", verificationID)
            completion(true)
        }
    }

    //Phone Auth: Verify code
    func verifyCode(smsCode: String, completion: @escaping (Bool) -> Void) {
        guard let verificationId = verificationId else {
            print("❌ verificationID is nil, call startAuth first")
            completion(false)
            return
        }

        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationId,
            verificationCode: smsCode
        )

        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("❌ verifyCode error:", error.localizedDescription)
                completion(false)
                return
            }

            print("✅ User signed in:", authResult?.user.uid ?? "")
            completion(true)
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
