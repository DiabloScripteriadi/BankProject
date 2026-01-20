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
        let password = userRequest.password
        
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
    public func signIn(with userRequest: LoginUSerRequest, completion: @escaping(Error?)-> Void){
        Auth.auth().signIn(withEmail: userRequest.email, password: userRequest.password) { (_, error) in
            if let error = error {
                completion(error)
            }
            completion(nil)
        }
    }
    public func signOut(completion: @escaping(Error?)-> Void){
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
            completion(signOutError)
        }
    }
}
