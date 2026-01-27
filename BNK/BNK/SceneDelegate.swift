//
//  SceneDelegate.swift
//  BankProject(BOG)
//
//  Created by chasemedkcorto on 05.01.26.
//
import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = scene as? UIWindowScene else { return }

        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        goToController(with: OnboardingVC())
    }


    func checkAuthentication() {
        if Auth.auth().currentUser == nil {
            print("User is NOT logged in")
            goToController(with: OnboardingVC())
        } else {
            print("User IS logged in")
            goToController(with: MobileNumberVC())
        }
    }
    func goToMain() {
        goToController(with: MobileNumberVC())
    }
    private func goToController(with vc: UIViewController?) {
    
        guard let window = window else {
            print("Error: window is nil")
            return
        }
        guard let vc = vc else {
            print("Error: vc is nil")
            return
        }

        let nav = UINavigationController(rootViewController: vc)
        window.rootViewController = nav

        UIView.transition(with: window,
                          duration: 0.5,
                          options: .transitionFlipFromRight,
                          animations: nil)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    func sceneWillResignActive(_ scene: UIScene) {
        
    }
    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
}
