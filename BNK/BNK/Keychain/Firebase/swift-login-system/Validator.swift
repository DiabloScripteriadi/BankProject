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

        // Minimum 6 chars, max 24, at least one letter and one number
        let passwordRegex =
        #"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,24}$"#

        return NSPredicate(format: "SELF MATCHES %@", passwordRegex)
            .evaluate(with: password)
    }

  //username
    static func isValidUsername(_ username: String) -> Bool {
        let username = username.trimmingCharacters(in: .whitespacesAndNewlines)

        // Letters, numbers, underscore, 4–20 chars
        let usernameRegex =
        #"^[A-Za-z0-9_]{4,20}$"#

        return NSPredicate(format: "SELF MATCHES %@", usernameRegex)
            .evaluate(with: username)
    }
}
