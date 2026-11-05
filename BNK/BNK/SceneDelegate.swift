import UIKit
import FirebaseAuth
import FirebaseFirestore
@main
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    let providerFactory = AppCheckDebugProviderFactory()
    AppCheck.setAppCheckProviderFactory(providerFactory)
    var window: UIWindow?
    private var navController: UINavigationController?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = scene as? UIWindowScene else { return }

        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()

        // 1. აუცილებელია ამ მეთოდის გამოძახება აპლიკაციის ჩართვისას!
        checkAuthentication()
    }
    func checkAuthentication() {
            guard let currentUser = Auth.auth().currentUser else {
                print("User is NOT logged in")
                goToController(with: GetStartedVc())
                return
            }

            print("User IS logged in. Checking profile completion...")
            let uid = currentUser.uid
            
            Firestore.firestore().collection("users").document(uid).getDocument { [weak self] document, error in
                guard let self = self else { return }
                
                if let document = document, document.exists {
                    let data = document.data()
                   
                    let hasFirstName = !(data?["firstName"] as? String ?? "").isEmpty
                    let hasLastName = !(data?["lastName"] as? String ?? "").isEmpty
                   
                    if hasFirstName && hasLastName {
                        print("✅ Profile is complete. Going to MainVC.")
                        self.goToController(with: OnboardingVC())
                    } else {
                        print("⚠️ Profile incomplete. Redirecting to More VC.")
                        self.goToController(with: MoreVc())
                    }
                } else {
                    print("❌ Document does not exist. Redirecting to More VC.")
                    self.goToController(with: OnboardingVC())
                }
            }
        }

        func goToMain() {
            goToController(with: LoadingVc()) // <--- და აქაც
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
