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
    //რეგისტრაცია უზერის უზერრექუესტ უზერის ინფორმაცია  ბოოლიანი გამოიყენება მაშნ როცა  უზერი დარეგისტრირებულია და დასეივებულია დათაბეისში სწორადდ
    public func registerUser(with userRequest: RegisterUserRequest,completion: @escaping (Bool, Error?) -> Void) {
        let username = userRequest.username
        let email = userRequest.email
        let password = userRequest.pasword
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            if let error = error {
                completion(false, error)
                return
            }
            guard let resultUser = result?.user else {
                completion(false,nil)
                return
            }
            let db = Firestore.firestore()
            db.collection("users")
                .document(resultUser.uid)
                .setData(["username" : username,
                          "email" : email]) { error in
                    if let error = error {
                        print("Error adding document: \(error)")
                    } else {
                        print("Document added with ID: \(resultUser.uid)")
                    }
                }
            
            completion(true, nil)
        }
    }
}
