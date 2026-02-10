//
//  GetStartedVc.swift
//  BankProject(BOG)
//
//  Created by chasemedkcorto on 05.01.26.
import UIKit

class GetStartedVc: UIViewController {

    private let stepLabel = UILabel()
    private let divider = UIView()

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    private let emailContainer = UIView()
    private let emailTextField = UITextField()
    private let emailFloatingLabel = UILabel()

    private let passwordContainer = UIView()
    private let passwordTextField = UITextField()
    private let passwordFloatingLabel = UILabel()
    private let passwordToggleButton = UIButton(type: .system)

    private let getStartedButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupStepLabel()
        setupDivider()
        setupTitleSection()
        setupEmailField()
        setupPasswordField()
        setupGetStartedButton()
        setupKeyboardToolbar()
        setupTapToDismiss()
    }

    private func setupStepLabel() {
        stepLabel.translatesAutoresizingMaskIntoConstraints = false
        stepLabel.text = "Step 1/5"
        stepLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        stepLabel.textColor = .secondaryLabel
        view.addSubview(stepLabel)

        NSLayoutConstraint.activate([
            stepLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            stepLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    private func setupDivider() {
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .label
        divider.layer.cornerRadius = 2
        view.addSubview(divider)

        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: stepLabel.bottomAnchor, constant: 8),
            divider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            divider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.28),
            divider.heightAnchor.constraint(equalToConstant: 4)
        ])
    }

    private func setupTitleSection() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.text = "Get started with your account"
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 0

        subtitleLabel.text = "Create your account using email and a secure password."
        subtitleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.numberOfLines = 0

        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 28),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }


    private func setupEmailField() {
        emailContainer.translatesAutoresizingMaskIntoConstraints = false
        emailContainer.layer.cornerRadius = 12
        emailContainer.backgroundColor = .secondarySystemBackground
        emailContainer.layer.borderWidth = 1
        emailContainer.layer.borderColor = UIColor.systemGray4.cgColor
        view.addSubview(emailContainer)

        NSLayoutConstraint.activate([
            emailContainer.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 28),
            emailContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailContainer.heightAnchor.constraint(equalToConstant: 56)
        ])

        emailFloatingLabel.translatesAutoresizingMaskIntoConstraints = false
        emailFloatingLabel.text = "Email Address"
        emailFloatingLabel.font = .systemFont(ofSize: 13, weight: .regular)
        emailFloatingLabel.textColor = .secondaryLabel
        emailFloatingLabel.backgroundColor = .systemBackground
        emailFloatingLabel.layer.cornerRadius = 4
        emailFloatingLabel.layer.masksToBounds = true
        emailContainer.addSubview(emailFloatingLabel)

        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.textColor = .label
        emailTextField.tintColor = .systemBlue
        emailTextField.addTarget(self, action: #selector(emailChanged), for: .editingChanged)
        emailContainer.addSubview(emailTextField)

        NSLayoutConstraint.activate([
            
            emailFloatingLabel.leadingAnchor.constraint(equalTo: emailContainer.leadingAnchor, constant: 14),
            emailFloatingLabel.centerYAnchor.constraint(equalTo: emailContainer.centerYAnchor),
            emailFloatingLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16),

            emailTextField.leadingAnchor.constraint(equalTo: emailContainer.leadingAnchor, constant: 14),
            emailTextField.trailingAnchor.constraint(equalTo: emailContainer.trailingAnchor, constant: -14),
            emailTextField.topAnchor.constraint(equalTo: emailContainer.topAnchor, constant: 18),
            emailTextField.bottomAnchor.constraint(equalTo: emailContainer.bottomAnchor, constant: -10)
        ])
    }

    private func setupPasswordField() {
        passwordContainer.translatesAutoresizingMaskIntoConstraints = false
        passwordContainer.layer.cornerRadius = 12
        passwordContainer.backgroundColor = .secondarySystemBackground
        passwordContainer.layer.borderWidth = 1
        passwordContainer.layer.borderColor = UIColor.systemGray4.cgColor
        view.addSubview(passwordContainer)

        NSLayoutConstraint.activate([
            passwordContainer.topAnchor.constraint(equalTo: emailContainer.bottomAnchor, constant: 16),
            passwordContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordContainer.heightAnchor.constraint(equalToConstant: 56)
        ])

        passwordFloatingLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordFloatingLabel.text = "Password"
        passwordFloatingLabel.font = .systemFont(ofSize: 13, weight: .regular)
        passwordFloatingLabel.textColor = .secondaryLabel
        passwordFloatingLabel.backgroundColor = .systemBackground
        passwordFloatingLabel.layer.cornerRadius = 4
        passwordFloatingLabel.layer.masksToBounds = true
        passwordContainer.addSubview(passwordFloatingLabel)

        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textColor = .label
        passwordTextField.tintColor = .systemBlue
        passwordTextField.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
        passwordContainer.addSubview(passwordTextField)

        passwordToggleButton.translatesAutoresizingMaskIntoConstraints = false
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        passwordToggleButton.tintColor = .tertiaryLabel
        passwordToggleButton.addTarget(self, action: #selector(togglePassword), for: .touchUpInside)
        passwordContainer.addSubview(passwordToggleButton)

        NSLayoutConstraint.activate([
            passwordFloatingLabel.leadingAnchor.constraint(equalTo: passwordContainer.leadingAnchor, constant: 14),
            passwordFloatingLabel.centerYAnchor.constraint(equalTo: passwordContainer.centerYAnchor),
            passwordFloatingLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16),

            passwordToggleButton.trailingAnchor.constraint(equalTo: passwordContainer.trailingAnchor, constant: -12),
            passwordToggleButton.centerYAnchor.constraint(equalTo: passwordContainer.centerYAnchor),
            passwordToggleButton.widthAnchor.constraint(equalToConstant: 24),
            passwordToggleButton.heightAnchor.constraint(equalToConstant: 24),

            passwordTextField.leadingAnchor.constraint(equalTo: passwordContainer.leadingAnchor, constant: 14),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordToggleButton.leadingAnchor, constant: -8),
            passwordTextField.topAnchor.constraint(equalTo: passwordContainer.topAnchor, constant: 18),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordContainer.bottomAnchor, constant: -10)
        ])
    }

    
    private func setupGetStartedButton() {
        getStartedButton.translatesAutoresizingMaskIntoConstraints = false
        getStartedButton.setTitle("Get Started", for: .normal)
        getStartedButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        getStartedButton.setTitleColor(.white, for: .normal)
        getStartedButton.backgroundColor = .systemGray4
        getStartedButton.layer.cornerRadius = 14
        getStartedButton.isEnabled = false
        getStartedButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)

        view.addSubview(getStartedButton)

        NSLayoutConstraint.activate([
            getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getStartedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            getStartedButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 220),
            getStartedButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }


    @objc private func didTapSignUp() {
        let registerUserRequest = RegisterUserRequest(username: "", email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "")

        if !Validator.isValidEmail(registerUserRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
        }
        if !Validator.isValidPassword(registerUserRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
        }

        AuthService.shared.registerUser(with: registerUserRequest) { [weak self] success, error in
            guard let self = self else { return }

            if let error = error {
                AlertManager.showRegistrationErrorAlert(on: self, with: error)
                return
            }

            if success {
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.goToMain()
                }
            }
        }
    }

    private func setupKeyboardToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
        toolbar.items = [flex, done]
        emailTextField.inputAccessoryView = toolbar
        passwordTextField.inputAccessoryView = toolbar
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
    
    @objc private func emailChanged() {
        animate(label: emailFloatingLabel, in: emailContainer, hasText: !(emailTextField.text?.isEmpty ?? true))
        updateButtonState()
    }

    @objc private func passwordChanged() {
        animate(label: passwordFloatingLabel, in: passwordContainer, hasText: !(passwordTextField.text?.isEmpty ?? true))
        updateButtonState()
    }

    @objc private func togglePassword() {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eye.slash" : "eye"
        passwordToggleButton.setImage(UIImage(systemName: imageName), for: .normal)
        passwordToggleButton.tintColor = passwordTextField.isSecureTextEntry ? .tertiaryLabel : .label
    }

    private func animate(label: UILabel, in container: UIView, hasText: Bool) {
        UIView.animate(withDuration: 0.22, delay: 0, options: [.curveEaseInOut]) {
            label.transform = hasText
                ? CGAffineTransform(translationX: 0, y: -18).scaledBy(x: 0.88, y: 0.88)
                : .identity
            label.textColor = hasText ? .tertiaryLabel : .secondaryLabel
        }
    }

    private func updateButtonState() {
        let enabled = !(emailTextField.text?.isEmpty ?? true) &&
                      !(passwordTextField.text?.isEmpty ?? true)

        UIView.animate(withDuration: 0.22) {
            self.getStartedButton.isEnabled = enabled
            self.getStartedButton.backgroundColor = enabled ? .black : .systemGray4
        }
    }
}
