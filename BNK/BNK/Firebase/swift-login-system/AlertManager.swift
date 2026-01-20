//
//  AlertManager.swift
//  BNK
//
//  Created by chasemedkcorto on 16.01.26.
//
import UIKit

class AlertManager {

private static func showBasicAlert(on vc: UIViewController,title: String,message: String) {
      DispatchQueue.main.async {
            let alert = UIAlertController(title: title,message: message,preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
            vc.present(alert, animated: true)
        }
    }
}

//validacia alertebis
extension AlertManager {

    public static func showInvalidEmailAlert(on vc: UIViewController) {
        showBasicAlert(on: vc,title: "Invalid Email",message: "Please enter a valid email")
    }

    public static func showInvalidPasswordAlert(on vc: UIViewController) {
        showBasicAlert(on: vc,title: "Invalid Password",message: "Please enter a valid password"
        )
    }

    public static func showInvalidUsernameAlert(on vc: UIViewController) {
        showBasicAlert(
            on: vc,title: "Invalid Username",message: "Please enter a valid username")
    }
}

//registraciis erorebi
extension AlertManager {

    public static func showRegistrationErrorAlert(on vc: UIViewController,message: String) {
        showBasicAlert(on: vc,title: "Registration Error",message: message)
}
    public static func showRegistrationErrorAlert(on vc: UIViewController,message: String, error: Error) {
        showBasicAlert(on: vc, title: "unknow Registration Errror", message:"\(error.localizedDescription)")
}
}
//login error
extension AlertManager {
    
    public static func showSigninError(on vc: UIViewController,message: String) {
        showBasicAlert(on: vc,title: "Registration Error Signing in",message: message)
    }
    public static func showSignInErrorAlert(on vc: UIViewController,message: String, error: Error) {
        showBasicAlert(on: vc, title: "unknow Registration Errror", message:"\(error.localizedDescription)")
    }
}
//log out error
extension AlertManager {
    public static func showLogoutError(on vc: UIViewController,message: String, error: Error) {
        showBasicAlert(on: vc, title: "Logout Error", message:"\(error.localizedDescription)")
    }
}
//forhgot password
extension AlertManager {
    public static func showPaswordResetSent(on vc: UIViewController,message: String) {
        showBasicAlert(on: vc,title: "Registration Error Signing in",message: message)
    }
    public static func showErrorSendingPaswordReset(on vc: UIViewController,message: String, error: Error) {
        showBasicAlert(on: vc, title: "Error Sending Pasword Reset", message:"\(error.localizedDescription)")
    }
}
//fetchings errorrebi
extension AlertManager {
    public static func fetchingUserEror(on vc: UIViewController,message: String) {
        showBasicAlert(on: vc,title: " Error Fetchin User",message: message)
    }
    public static func showUnknowFetchingUser(on vc: UIViewController,message: String, error: Error) {
        showBasicAlert(on: vc, title: "Unknown Eror Fetching User", message:"\(error.localizedDescription)")
    }
}
