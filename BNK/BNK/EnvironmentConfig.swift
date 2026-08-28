//
//  EnvironmentConfig.swift
//  BNK
//
//  Created by chasemedkcorto on 21.07.26.
//

import Foundation
import FirebaseCore

/// აპის გარემო (საჭიროების შემთხვევაში დაამატე .staging/.production)
enum AppEnvironment: String {
    case debug
    case release
}

struct EnvironmentConfig {

    /// კომპილაციის დროშებით ვასხვავებთ გარემოს.
    static var current: AppEnvironment {
        #if DEBUG
        return .debug
        #else
        return .release
        #endif
    }

    /// FirebaseOptions თუ დააბრუნა, AppBootstrapper გამოიყენებს მას.
    /// ახლა ნაგულისხმევად ვაბრუნებთ nil-ს, რომ პროექტში არსებულ GoogleService-Info.plist-ს დაეყრდნოს.
    static func firebaseOptions() -> FirebaseOptions? {
        switch current {
        case .debug:
            // return options(named: "GoogleService-Info-Debug")
            return nil
        case .release:
            // return options(named: "GoogleService-Info-Release")
            return nil
        }
    }

    private static func options(named name: String) -> FirebaseOptions? {
        guard let path = Bundle.main.path(forResource: name, ofType: "plist"),
              let options = FirebaseOptions(contentsOfFile: path) else {
            assertionFailure("FirebaseOptions not found for \(name).plist")
            return nil
        }
        return options
    }
}

