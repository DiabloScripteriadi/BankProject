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
    private let getStartedButton = UIButton(type: .system)

    private let emailContainer = UIView()
    private let emailTextField = UITextField()
    private let emailFloatingLabel = UILabel()

    private let passwordContainer = UIView()
    private let passwordTextField = UITextField()
    private let passwordFloatingLabel = UILabel()
    private let passwordToggleButton = UIButton(type: .system)

 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupStepLabel()
        setupDivider()
        setupTitleLabel()
        setupEmailField()
        setupPasswordField()
        setupGetStartedButton()
    }

    private func setupStepLabel() {
        stepLabel.translatesAutoresizingMaskIntoConstraints = false
        stepLabel.text = "Step 1/5"
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
            divider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            divider.heightAnchor.constraint(equalToConstant: 5)
        ])
    }

    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Get started with your account!"
        titleLabel.font = .systemFont(ofSize: 25, weight: .semibold)
        titleLabel.numberOfLines = 0
        view.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 35),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }


    private func setupEmailField() {
        emailContainer.translatesAutoresizingMaskIntoConstraints = false
        emailContainer.layer.cornerRadius = 10
        emailContainer.layer.borderWidth = 1
        emailContainer.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(emailContainer)

        NSLayoutConstraint.activate([
            emailContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            emailContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailContainer.heightAnchor.constraint(equalToConstant: 56)
        ])

        emailFloatingLabel.translatesAutoresizingMaskIntoConstraints = false
        emailFloatingLabel.text = "Email Addresss"
        emailFloatingLabel.font = .systemFont(ofSize: 14)
        emailFloatingLabel.textColor = .gray
        emailContainer.addSubview(emailFloatingLabel)

        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
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


    private func setupPasswordField() {
        passwordContainer.translatesAutoresizingMaskIntoConstraints = false
        passwordContainer.layer.cornerRadius = 10
        passwordContainer.layer.borderWidth = 1
        passwordContainer.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(passwordContainer)

        NSLayoutConstraint.activate([
            passwordContainer.topAnchor.constraint(equalTo: emailContainer.bottomAnchor, constant: 24),
            passwordContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordContainer.heightAnchor.constraint(equalToConstant: 56)
        ])

        passwordFloatingLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordFloatingLabel.text = "Password"
        passwordFloatingLabel.font = .systemFont(ofSize: 14)
        passwordFloatingLabel.textColor = .gray
        passwordContainer.addSubview(passwordFloatingLabel)

        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.isSecureTextEntry = true
        passwordTextField.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
        passwordContainer.addSubview(passwordTextField)

        // Eye Button
        passwordToggleButton.translatesAutoresizingMaskIntoConstraints = false
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        passwordToggleButton.tintColor = .gray
        passwordToggleButton.addTarget(self, action: #selector(togglePassword), for: .touchUpInside)
        passwordContainer.addSubview(passwordToggleButton)

        NSLayoutConstraint.activate([
            passwordFloatingLabel.leadingAnchor.constraint(equalTo: passwordContainer.leadingAnchor, constant: 12),
            passwordFloatingLabel.centerYAnchor.constraint(equalTo: passwordContainer.centerYAnchor),

            passwordToggleButton.trailingAnchor.constraint(equalTo: passwordContainer.trailingAnchor, constant: -12),
            passwordToggleButton.centerYAnchor.constraint(equalTo: passwordContainer.centerYAnchor),
            passwordToggleButton.widthAnchor.constraint(equalToConstant: 24),
            passwordToggleButton.heightAnchor.constraint(equalToConstant: 24),

            passwordTextField.leadingAnchor.constraint(equalTo: passwordContainer.leadingAnchor, constant: 12),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordToggleButton.leadingAnchor, constant: -8),
            passwordTextField.topAnchor.constraint(equalTo: passwordContainer.topAnchor, constant: 18),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordContainer.bottomAnchor, constant: -8)
        ])
    }


    private func setupGetStartedButton() {
        getStartedButton.translatesAutoresizingMaskIntoConstraints = false
        getStartedButton.setTitle("Get Started", for: .normal)
        getStartedButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        getStartedButton.setTitleColor(.white, for: .normal)
        getStartedButton.backgroundColor = .systemGray4
        getStartedButton.layer.cornerRadius = 15
        getStartedButton.isEnabled = false
        view.addSubview(getStartedButton)

        NSLayoutConstraint.activate([
            getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getStartedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            getStartedButton.widthAnchor.constraint(equalToConstant: 300),
            getStartedButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }


    @objc private func emailChanged() {
        animate(label: emailFloatingLabel, hasText: !(emailTextField.text?.isEmpty ?? true))
        updateButtonState()
    }

    @objc private func passwordChanged() {
        animate(label: passwordFloatingLabel, hasText: !(passwordTextField.text?.isEmpty ?? true))
        updateButtonState()
    }

    @objc private func togglePassword() {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eye.slash" : "eye"
        passwordToggleButton.setImage(UIImage(systemName: imageName), for: .normal)
    }


    private func animate(label: UILabel, hasText: Bool) {
        UIView.animate(withDuration: 0.25) {
            label.transform = hasText
                ? CGAffineTransform(translationX: 0, y: -18).scaledBy(x: 0.85, y: 0.85)
                : .identity
        }
    }

    private func updateButtonState() {
        let enabled = !(emailTextField.text?.isEmpty ?? true) &&
                      !(passwordTextField.text?.isEmpty ?? true)

        UIView.animate(withDuration: 0.25) {
            self.getStartedButton.isEnabled = enabled
            self.getStartedButton.backgroundColor = enabled ? .black : .systemGray4
        }
    }
}
