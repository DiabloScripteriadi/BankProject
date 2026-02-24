//
//  File.swift
//  BNK
//
//  Created by chasemedkcorto on 20.01.26.
//
import Foundation

final class Validator {
//email
    static func isValidEmail(_ email: String) -> Bool {
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)

        let emailRegex =
        #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#

        return NSPredicate(format: "SELF MATCHES %@", emailRegex)
            .evaluate(with: email)
    }
//pasword

    static func isValidPassword(_ password: String) -> Bool {
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
         //მინიმუმი 6 მაქსიმუმი 24
        let passwordRegex =
        #"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,24}$"#

        return NSPredicate(format: "SELF MATCHES %@", passwordRegex)
            .evaluate(with: password)
    }

  //username
    static func isValidUsername(_ username: String) -> Bool {
        let username = username.trimmingCharacters(in: .whitespacesAndNewlines)

        let usernameRegex =
        #"^[A-Za-z0-9_]{4,20}$"#

        return NSPredicate(format: "SELF MATCHES %@", usernameRegex)
            .evaluate(with: username)
    }
}
