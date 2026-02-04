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
        view.backgroundColor = .systemBackground
        
        setupStepLabel()
        setupDivider()
        setupTitleLabel()
        setupEmailField()
        setupPasswordField()
        setupGetStartedButton()
        setupForgotPasswordButton()
        setupRemember()
        setupKeyboardToolbar()
        setupTapToDismiss()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
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
        forgotPasswordButton.setTitleColor(.label, for: .normal)
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
        view.addSubview(divider)
        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: stepLabel.bottomAnchor, constant: 8),
            divider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            divider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            divider.heightAnchor.constraint(equalToConstant: 5)
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Login To your Account"
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .label
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 28),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupEmailField() {
        emailContainer.translatesAutoresizingMaskIntoConstraints = false
        emailContainer.layer.cornerRadius = 12
        emailContainer.layer.borderWidth = 1
        emailContainer.layer.borderColor = UIColor.systemGray4.cgColor
        emailContainer.backgroundColor = .secondarySystemBackground
        view.addSubview(emailContainer)
        NSLayoutConstraint.activate([
            emailContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 28),
            emailContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailContainer.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        emailFloatingLabel.translatesAutoresizingMaskIntoConstraints = false
        emailFloatingLabel.text = "Email Addresss"
        emailFloatingLabel.font = .systemFont(ofSize: 13)
        emailFloatingLabel.textColor = .secondaryLabel
        emailFloatingLabel.backgroundColor = .systemBackground
        emailFloatingLabel.layer.cornerRadius = 4
        emailFloatingLabel.layer.masksToBounds = true
        emailContainer.addSubview(emailFloatingLabel)
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.textColor = .label
        emailTextField.addTarget(self, action: #selector(emailChanged), for: .editingChanged)
        emailContainer.addSubview(emailTextField)
        
        NSLayoutConstraint.activate([
            emailFloatingLabel.leadingAnchor.constraint(equalTo: emailContainer.leadingAnchor, constant: 12),
            emailFloatingLabel.centerYAnchor.constraint(equalTo: emailContainer.centerYAnchor),
            emailFloatingLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16),
            
            emailTextField.leadingAnchor.constraint(equalTo: emailContainer.leadingAnchor, constant: 12),
            emailTextField.trailingAnchor.constraint(equalTo: emailContainer.trailingAnchor, constant: -12),
            emailTextField.topAnchor.constraint(equalTo: emailContainer.topAnchor, constant: 18),
            emailTextField.bottomAnchor.constraint(equalTo: emailContainer.bottomAnchor, constant: -8)
        ])
    }
    
    private func setupPasswordField() {
        passwordContainer.translatesAutoresizingMaskIntoConstraints = false
        passwordContainer.layer.cornerRadius = 12
        passwordContainer.layer.borderWidth = 1
        passwordContainer.layer.borderColor = UIColor.systemGray4.cgColor
        passwordContainer.backgroundColor = .secondarySystemBackground
        view.addSubview(passwordContainer)
        NSLayoutConstraint.activate([
            passwordContainer.topAnchor.constraint(equalTo: emailContainer.bottomAnchor, constant: 16),
            passwordContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordContainer.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        passwordFloatingLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordFloatingLabel.text = "Password"
        passwordFloatingLabel.font = .systemFont(ofSize: 13)
        passwordFloatingLabel.textColor = .secondaryLabel
        passwordFloatingLabel.backgroundColor = .systemBackground
        passwordFloatingLabel.layer.cornerRadius = 4
        passwordFloatingLabel.layer.masksToBounds = true
        view.addSubview(passwordFloatingLabel)
        passwordContainer.addSubview(passwordFloatingLabel)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textColor = .label
        passwordTextField.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
        passwordContainer.addSubview(passwordTextField)
        
        passwordToggleButton.translatesAutoresizingMaskIntoConstraints = false
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        passwordToggleButton.tintColor = .tertiaryLabel
        passwordToggleButton.addTarget(self, action: #selector(togglePassword), for: .touchUpInside)
        passwordContainer.addSubview(passwordToggleButton)
        
        NSLayoutConstraint.activate([
            passwordFloatingLabel.leadingAnchor.constraint(equalTo: passwordContainer.leadingAnchor, constant: 12),
            passwordFloatingLabel.centerYAnchor.constraint(equalTo: passwordContainer.centerYAnchor),
            passwordFloatingLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16),
            
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
        getStartedButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        getStartedButton.setTitleColor(.white, for: .normal)
        getStartedButton.backgroundColor = .systemGray4
        getStartedButton.layer.cornerRadius = 14
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
            if self.view.window?.windowScene?.delegate is SceneDelegate {
                let vc  = LoginPasscodeVC()
                self.navigationController!.pushViewController(vc, animated: true)
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
}
