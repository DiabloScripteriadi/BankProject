//
//  LoginVC.swift
//  BNK
//
//  Created by chasemedkcorto on 12.01.26.
//
import UIKit
import FirebaseAuth

class loginVC: UIViewController {
    
    
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
    
    private let rememberButton = checkBox()
    private let rememberLabel = UILabel()
    
    private let forgotPasswordButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupStepLabel()
        setupDivider()
        setupTitleLabel()
        setupEmailField()
        setupPasswordField()
        setupGetStartedButton()
        setupForgotPasswordButton()
        setupRemember()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
    }
    //    private func checkBox() {
    //        let checkbox = CircularCheckbox(frame: CGRect(x: 70, y: 200, width: 70, height: 70))
    //        label.text = "sss"
    //        view.addSubview(checkbox)
    //        view.addSubview(label)
    //        let label1 = UILabel(frame: CGRect(x: 150, y: 200, width: 200, height: 70))
    //    }
    private func setupRemember() {
        view.addSubview(rememberButton)
        rememberButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rememberButton.topAnchor.constraint(equalTo: passwordContainer.bottomAnchor, constant: 14),
            rememberButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    private func setupForgotPasswordButton() {
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.setTitle("Forgot Password?", for: .normal)
        forgotPasswordButton.setTitleColor(.black, for: .normal)
        forgotPasswordButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        forgotPasswordButton.contentHorizontalAlignment = .right
        
        view.addSubview(forgotPasswordButton)
        
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordContainer.bottomAnchor, constant: 8),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
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
            divider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6   ),
            divider.heightAnchor.constraint(equalToConstant: 5)
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Login To your Account"
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
        getStartedButton.setTitle("Login", for: .normal)
        getStartedButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        getStartedButton.setTitleColor(.white, for: .normal)
        getStartedButton.backgroundColor = .systemGray4
        getStartedButton.layer.cornerRadius = 15
        getStartedButton.isEnabled = false
        getStartedButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        
        
        view.addSubview(getStartedButton)
        
        NSLayoutConstraint.activate([
            getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getStartedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            getStartedButton.widthAnchor.constraint(equalToConstant: 300),
            getStartedButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    //selectorebi romelitac funqcionali ketdeba
    
    @objc private func didTapSignIn() {

        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        guard Validator.isValidEmail(email) else {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }

        guard Validator.isValidPassword(password) else {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }

        let request = LoginUSerRequest(email: email, password: password)

        AuthService.shared.signIn(with: request) { [weak self] error in
            guard let self = self else { return }

            if let error = error {
                AlertManager.showSignInErrorAlert(on: self, with: error)
                return
            }

            // ✅ წარმატებით დალოგინდა
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.goToMain()
            }
        }
    }

    
    @objc private func didTapNewUser() {
        let vc = GetStartedVc()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func didTapForgotPassword() {
        let vc = ForgotPaswordVC()
        navigationController?.pushViewController(vc, animated: true)
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
