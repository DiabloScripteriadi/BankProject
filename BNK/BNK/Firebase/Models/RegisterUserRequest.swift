//
//  RegisterUserRequest.swift
//  BNK
//
//  Created by chasemedkcorto on 16.01.26.
//

import Foundation
import FirebaseFirestore
struct RegisterUserRequest {
   let username: String
   let email: String
   let password: String
   let phone: String
}
struct LoginUSerRequest {
    let email: String
    let password: String
}
struct CardModel: Codable {
    let id: String?
    let last4: String
    let brand: String
    let paymentMethodId: String
    @ServerTimestamp var updatedAt: Timestamp?
}
