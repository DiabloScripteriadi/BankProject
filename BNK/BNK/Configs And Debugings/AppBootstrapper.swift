//
//  AppBootstrapper.swift
//  BNK
//
//  Created by chasemedkcorto on 21.07.26.
//

import Foundation
import FirebaseCore

/// AppBootstrapper არის ერთიანი ადგილი, სადაც ხდება აპის გაშვებისას
/// ყველა აუცილებელი სერვისის ინიციალიზაცია (მაგ: Firebase, Logger, Feature Flags).
/// იდეა არის, რომ AppDelegate დარჩეს თხელი და მხოლოდ გამოიძახოს ეს bootstrapper.
final class AppBootstrapper {

    /// აპის გაშვებისას გამოძახებული საჯარო მეთოდი.
    /// აქედან ხდება ყველა სერვისის კონფიგურაცია/ინიციალიზაცია.
    func configureServices() {
        configureFirebase()
        configureLogger()
        //  სხვა სერვისები:
        // configureCrashReporting()
        configureAnalytics()
        // configureRemoteConfig()
        logLaunchInfoIfNeeded()
        // performHealthCheckIfNeeded()
    }

    // MARK: - Firebase

    /// Firebase-ის ინიციალიზაცია.
    /// თუ EnvironmentConfig.firebaseOptions() დააბრუნებს options-ს, გამოვიყენებთ მას.
    /// წინააღმდეგ შემთხვევაში, დავეყრდნობით ნაგულისხმევ GoogleService-Info.plist-ს.
    private func configureFirebase() {
        if let options = EnvironmentConfig.firebaseOptions() {
            FirebaseApp.configure(options: options)
            AppLogger.log("Firebase configured with explicit options for \(EnvironmentConfig.current)", level: .info, category: "Bootstrap")
        } else {
            FirebaseApp.configure()
            AppLogger.log("Firebase configured with default plist", level: .info, category: "Bootstrap")
        }
    }

    // MARK: - Logger

    /// შენი აპის ლოგერის კონფიგურაცია (მარტივი wrapper).
    private func configureLogger() {
        // ამ ეტაპზე AppLogger setup არ საჭიროებს არაფერს,
        // მაგრამ თუ მომავალში დონის ცენტრალიზაცია დაგჭირდება, დაამატე აქ.
        AppLogger.log("Logger configured", level: .debug, category: "Bootstrap")
    }

    // MARK: - Debug Logging

    /// გაშვების ინფორმაციის დაბეჭდვა მხოლოდ Debug ბილდებში.
    /// სასარგებლოა დიაგნოსტიკისთვის, რომ უცებ დაინახო რომელი გარემოა, რა ბილდია და ა.შ.
    private func logLaunchInfoIfNeeded() {
        #if DEBUG
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "unknown"
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "unknown"
        AppLogger.log("App did finish launching. Version: \(version) (\(build)), env: \(EnvironmentConfig.current.rawValue)", level: .debug, category: "Bootstrap")
        #endif
    }

    // MARK: - Optional Future Hooks (შეგიძლია გააქტიურო საჭიროების მიხედვით)

    /// Crash Reporting-ის ჩართვის ადგილი (მაგ: Crashlytics/Sentry).
    /// Release ბილდში ჩართე, Debug-ში — სურვილის მიხედვით.
    private func configureCrashReporting() {
        // მაგალითი (თუ მომავალში დაამატებ Crashlytics-ს):
        // #if !DEBUG
        // Crashlytics.crashlytics()
        // #endif
    }

    /// Analytics-ის ჩართვის ადგილი (Firebase Analytics ან სხვა).
    private func configureAnalytics() {
        // მაგალითი:
        // Analytics.setAnalyticsCollectionEnabled(true)
    }

    /// Remote Config-ის ჩართვის ადგილი, Feature Flag-ებისთვის.
    private func configureRemoteConfig() {
        // მაგალითი:
        // let remoteConfig = RemoteConfig.remoteConfig()
        // let settings = RemoteConfigSettings()
        // settings.minimumFetchInterval = 0 // Debug-ში სწრაფი ტესტისთვის
        // remoteConfig.configSettings = settings
        // remoteConfig.fetchAndActivate { status, error in
        //     if let error { AppLogger.log("RemoteConfig error: \(error)", level: .error, category: "Bootstrap") }
        // }
    }

    /// Health Check — შეგიძლია გააკეთო სწრაფი თვითშემოწმება გაშვებისას:
    /// ქსელის ხელმისაწვდომობა, კრიტიკული ფაილების არსებობა და ა.შ.
    private func performHealthCheckIfNeeded() {
        // მაგალითი:
        // assert(Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") != nil,
        //        "GoogleService-Info.plist is missing in bundle.")
    }
}

