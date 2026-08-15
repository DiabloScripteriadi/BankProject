//
//  AppBootstrapper.swift
//  BNK
//
//  Created by chasemedkcorto on 21.07.26.
//

import Foundation
import FirebaseCore

final class AppBootstrapper {

    func configureServices() {
        configureFirebase()
        logLaunchInfoIfNeeded()
    }

    // MARK: - Private

    private func configureFirebase() {
        // If you later need multiple environments, inject FirebaseOptions here.
        FirebaseApp.configure()
    }

    private func logLaunchInfoIfNeeded() {
        #if DEBUG
        print("[AppBootstrapper] App did finish launching (Debug)")
        #endif
    }
}

