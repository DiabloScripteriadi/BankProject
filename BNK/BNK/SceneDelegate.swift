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
    private var navController: UINavigationController?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = scene as? UIWindowScene else { return }

        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()

        goToController(with: SpaceVC())
    }

    func checkAuthentication() {
        if Auth.auth().currentUser == nil {
            print("User is NOT logged in")
            goToController(with: OnboardingVC())
        } else {
            print("User IS logged in")
            goToController(with: LoadingVc())
        }
    }

    func goToMain() {
        goToController(with: OnboardingVC())
    }

    func goToMobileVc() { // for GetStartedVc
        let vc = MobileNumberVC()
        navController?.pushViewController(vc, animated: true)
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
        navController = nav
        window.rootViewController = nav
    }

    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
    func sceneDidEnterBackground(_ scene: UIScene) { }
}
