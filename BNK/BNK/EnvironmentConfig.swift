//
//  EnvironmentConfig.swift
//  BNK
//
//  Created by chasemedkcorto on 21.07.26.
//

import Foundation
import FirebaseCore

enum AppEnvironment: String {
    case debug
    case release
    // დამატებით: case staging, case production
}

struct EnvironmentConfig {

    // ამოიცნობს გარემოს კომპილაციის დროშებით.
    static var current: AppEnvironment {
        #if DEBUG
        return .debug
        #else
        return .release
        #endif
    }

    // თუ ერთიან plist-ს იყენებ, ეს მეთოდი უბრალოდ დააბრუნებს nil-ს და FirebaseApp.configure() გამოიყენებს ნაგულისხმევს.
    // თუ სხვადასხვა plist გექნება, აქ ჩატვირთავ შესაბამისს.
    static func firebaseOptions() -> FirebaseOptions? {
        switch current {
        case .debug:
            // თუ გინდა Debug-ზე ცალკე პროექტი:
            // return options(named: "GoogleService-Info-Debug")
            return nil
        case .release:
            // თუ Release-ზე სხვა plist გაქვს:
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

