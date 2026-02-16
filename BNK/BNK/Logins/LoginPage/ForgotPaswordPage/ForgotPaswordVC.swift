//
//  ForgotPaswordVC.swift
//  BNK
//
//  Created by chasemedkcorto on 18.01.26.
//

import UIKit
import FirebaseAuth
import SwiftUI

final class ForgotPaswordVC: UIViewController {
 
    private let stepLabel = UILabel()
    private let divider = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let getStartedButton = UIButton(type: .system)
    
    private let emailContainer = UIView()
    private let emailTextField = UITextField()
    private let emailFloatingLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupStepLabel()
        setupDivider()
        setupTitleLabel()
        setupEmailField()
        setupGetStartedButton()
        setupKeyboardToolbar()
        setupTapToDismiss()
    }

    private func setupStepLabel() {
        stepLabel.translatesAutoresizingMaskIntoConstraints = false
        stepLabel.text = "Step 1/2"
        stepLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        stepLabel.textColor = .gray
        view.addSubview(stepLabel)

        NSLayoutConstraint.activate([
            stepLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stepLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    private func setupDivider() {
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .black
        view.addSubview(divider)

        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: stepLabel.bottomAnchor, constant: 8),
            divider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            divider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            divider.heightAnchor.constraint(equalToConstant: 5)
        ])
    }

    private func setupTitleLabel() {
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Forgot Password"
        titleLabel.font = .systemFont(ofSize: 25, weight: .semibold)
        titleLabel.numberOfLines = 0
        view.addSubview(titleLabel)

        subtitleLabel.text = "Oh sorry! Enter your email address below and we will send you a reset link."
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.textColor = .gray
        subtitleLabel.numberOfLines = 0

        view.addSubview(subtitleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 35),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }

    private func setupEmailField() {
        emailContainer.translatesAutoresizingMaskIntoConstraints = false
        emailContainer.layer.cornerRadius = 10
        emailContainer.layer.borderWidth = 1
        emailContainer.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(emailContainer)

        NSLayoutConstraint.activate([
            emailContainer.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 40),
            emailContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailContainer.heightAnchor.constraint(equalToConstant: 56)
        ])

        emailFloatingLabel.translatesAutoresizingMaskIntoConstraints = false
        emailFloatingLabel.text = "Email Address"
        emailFloatingLabel.font = .systemFont(ofSize: 14)
        emailFloatingLabel.textColor = .gray
        emailContainer.addSubview(emailFloatingLabel)

        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.textContentType = .emailAddress
        emailTextField.addTarget(self, action: #selector(emailChanged), for: .editingChanged)
        emailContainer.addSubview(emailTextField)

        NSLayoutConstraint.activate([
            emailFloatingLabel.leadingAnchor.constraint(equalTo: emailContainer.leadingAnchor, constant: 12),
            emailFloatingLabel.centerYAnchor.constraint(equalTo: emailContainer.centerYAnchor),

            emailTextField.leadingAnchor.constraint(equalTo: emailContainer.leadingAnchor, constant: 12),
            emailTextField.trailingAnchor.constraint(equalTo: emailContainer.trailingAnchor, constant: -12),
            emailTextField.topAnchor.constraint(equalTo: emailContainer.topAnchor, constant: 18),
            emailTextField.bottomAnchor.constraint(equalTo: emailContainer.bottomAnchor, constant: -8)
        ])
    }

    private func setupGetStartedButton() {
        getStartedButton.translatesAutoresizingMaskIntoConstraints = false
        getStartedButton.setTitle("Next", for: .normal)
        getStartedButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        getStartedButton.setTitleColor(.white, for: .normal)
        getStartedButton.backgroundColor = .systemGray4
        getStartedButton.layer.cornerRadius = 15
        getStartedButton.isEnabled = false
        getStartedButton.addTarget(self, action: #selector(forgotPasworedTapped), for: .touchUpInside)
        view.addSubview(getStartedButton)

        NSLayoutConstraint.activate([
            getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getStartedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            getStartedButton.widthAnchor.constraint(equalToConstant: 300),
            getStartedButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    private func setupKeyboardToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
        toolbar.items = [flex, done]
        emailTextField.inputAccessoryView = toolbar
    }

    private func setupTapToDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func doneTapped() {
        view.endEditing(true)
    }

    @objc private func handleBackgroundTap() {
        view.endEditing(true)
    }

    @objc private func forgotPasworedTapped() {
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        // Optional but recommended: basic email validation
        guard Validator.isValidEmail(email) else {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }

        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                AlertManager.showErrorSendingPasswordReset(on: self, with: error)
                let vc = OnboardingVC()
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                AlertManager.showPasswordResetSent(on: self)
            }
        }
    }
#warning("სპამში გამოიგზავნება ჯიმაილის პაროლი და იქ შეგიძლია შეცვალო")
    @objc private func emailChanged() {
        animate(label: emailFloatingLabel, hasText: !(emailTextField.text?.isEmpty ?? true))
        updateButtonState()
    }

    private func animate(label: UILabel, hasText: Bool) {
        UIView.animate(withDuration: 0.25) {
            label.transform = hasText
                ? CGAffineTransform(translationX: 0, y: -18).scaledBy(x: 0.85, y: 0.85)
                : .identity
        }
    }

    private func updateButtonState() {
        let text = emailTextField.text ?? ""
        let enabled = !text.isEmpty
        UIView.animate(withDuration: 0.25) {
            self.getStartedButton.isEnabled = enabled
            self.getStartedButton.backgroundColor = enabled ? .black : .systemGray4
        }
    }
}
//#Preview {
//    let vc = ForgotPaswordVC()
//    UINavigationController(rootViewController: vc)
//}
#warning("rodesac gadava backbuttoni mosacilebeli titqmis yvelgan")
