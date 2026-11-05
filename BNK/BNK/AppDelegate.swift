//
//  AppDelegate.swift
//  BankProject(BOG)
//
//  Created by chasemedkcorto on 05.01.26.
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAppCheck

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let providerFactory = AppCheckDebugProviderFactory()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        bootstrapper.configureServices()
        // 1. Firebase-ის ინიციალიზაცია
        AppCheck.setAppCheckProviderFactory(providerFactory)
        FirebaseApp.configure()
        
        // 2. ემულატორთან კავშირი (მხოლოდ დეველოპმენტის რეჟიმში)
//        #if DEBUG
//        let settings = Firestore.firestore().settings
//        settings.host = "192.168.1.192" // localhost:8080-ის ნაცვლად უმჯობესია გამოიყენო 127.0.0.1:8080 [1.1.2]
//        settings.cacheSettings = MemoryCacheSettings() // ახალ SDK-ში isPersistenceEnabled-ის ნაცვლად [1.1.2, 1.2.1]
//        settings.isSSLEnabled = false
//        Firestore.firestore().settings = settings
//        print("🔥 Firestore Emulator connected successfully!")
//        #endif
//        192.168.1.192
//        "127.0.0.1:8080"
        return true
    }
    private let bootstrapper = AppBootstrapper()
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration",
                                    sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication,
                     didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
