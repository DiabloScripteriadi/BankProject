//
//  GetStartedVc.swift
//  BankProject(BOG)
//
//  Created by chasemedkcorto on 05.01.26.
import UIKit

final class GetStartedVc: UIViewController, UITextFieldDelegate {

    private final class FloatingField {
        let container = UIView()
        let textField = UITextField()
        let label = UILabel()
        var hasText: Bool { !(textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true) }
        var trimmed: String { textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "" }
    }

    private let scrollView = UIScrollView()
    private let content = UIStackView()

    private let stepLabel = UILabel()
    private let dividerWrapper = UIView()
    private let divider = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    private let emailField = FloatingField()
    private let passwordField = FloatingField()
    private let firstNameField = FloatingField()
    private let lastNameField = FloatingField()

    private let dobContainer = UIView()
    private let dobLabel = UILabel()
    private let dateTextField = UITextField()

    private let passwordToggleButton = UIButton(type: .system)
    private let getStartedButton = UIButton(type: .system)

    private let datePicker = UIDatePicker()
    private var selectedBirthDate: Date?

    private var fields: [FloatingField] {
        [emailField, passwordField, firstNameField, lastNameField]
    }

    private static let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.calendar = Calendar(identifier: .gregorian)
        f.locale = Locale(identifier: "en_US_POSIX")
        f.dateFormat = "yyyy-MM-dd"
        return f
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        setupHeader()
        setupFields()
        setupDOBField()
        setupDatePicker()
        setupButton()
        setupKeyboardHandling()
    }

    private func setupLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.keyboardDismissMode = .interactive
        scrollView.alwaysBounceVertical = true
        scrollView.contentInsetAdjustmentBehavior = .always
        view.addSubview(scrollView)

        content.translatesAutoresizingMaskIntoConstraints = false
        content.axis = .vertical
        content.spacing = 16
        scrollView.addSubview(content)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -96),

            content.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 12),
            content.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 16),
            content.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -16),
            content.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -16),
            content.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -32)
        ])
    }

    private func setupHeader() {
        stepLabel.text = "Step 1/5"
        stepLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        stepLabel.textColor = .secondaryLabel
        stepLabel.textAlignment = .right

        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .label
        divider.layer.cornerRadius = 2
        dividerWrapper.addSubview(divider)

        titleLabel.text = "Get started with your account"
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 0

        subtitleLabel.text = "Create your account using email and a secure password."
        subtitleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.numberOfLines = 0

        [stepLabel, dividerWrapper, titleLabel, subtitleLabel].forEach { content.addArrangedSubview($0) }

        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: dividerWrapper.topAnchor),
            divider.bottomAnchor.constraint(equalTo: dividerWrapper.bottomAnchor),
            divider.leadingAnchor.constraint(equalTo: dividerWrapper.leadingAnchor),
            divider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.28),
            divider.heightAnchor.constraint(equalToConstant: 4)
        ])

        content.setCustomSpacing(8, after: stepLabel)
        content.setCustomSpacing(28, after: dividerWrapper)
        content.setCustomSpacing(8, after: titleLabel)
        content.setCustomSpacing(28, after: subtitleLabel)
    }

    private func setupFields() {
        passwordToggleButton.translatesAutoresizingMaskIntoConstraints = false
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        passwordToggleButton.tintColor = .tertiaryLabel
        passwordToggleButton.addTarget(self, action: #selector(togglePassword), for: .touchUpInside)

        configure(emailField, title: "Email Address")
        emailField.textField.keyboardType = .emailAddress
        emailField.textField.autocapitalizationType = .none
        emailField.textField.autocorrectionType = .no
        emailField.textField.textContentType = .emailAddress

        configure(passwordField, title: "Password", rightView: passwordToggleButton)
        passwordField.textField.isSecureTextEntry = true
        passwordField.textField.textContentType = .newPassword
        passwordField.textField.autocorrectionType = .no
        passwordField.textField.autocapitalizationType = .none

        configure(firstNameField, title: "First Name", inset: 12, bottomInset: 6)
        firstNameField.textField.textContentType = .givenName
        firstNameField.textField.autocapitalizationType = .words

        configure(lastNameField, title: "Last Name", inset: 12, bottomInset: 6)
        lastNameField.textField.textContentType = .familyName
        lastNameField.textField.autocapitalizationType = .words

        fields.forEach { content.addArrangedSubview($0.container) }

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
        ]
        fields.forEach {
            $0.textField.inputAccessoryView = toolbar
            $0.textField.addTarget(self, action: #selector(editingBegan(_:)), for: .editingDidBegin)
            $0.textField.addTarget(self, action: #selector(editingEnded(_:)), for: .editingDidEnd)
        }

        let tap = UITapGestureRecognizer(target: self, action: #selector(doneTapped))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    private func configure(_ field: FloatingField, title: String, rightView: UIView? = nil, inset: CGFloat = 14, bottomInset: CGFloat = 10) {
        let container = field.container
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = 12
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor.systemGray4.cgColor
        container.backgroundColor = .secondarySystemBackground
        container.heightAnchor.constraint(equalToConstant: 56).isActive = true

        field.label.translatesAutoresizingMaskIntoConstraints = false
        field.label.text = title
        field.label.font = .systemFont(ofSize: 13, weight: .regular)
        field.label.textColor = .secondaryLabel
        field.label.backgroundColor = .systemBackground
        field.label.layer.cornerRadius = 4
        field.label.layer.masksToBounds = true
        container.addSubview(field.label)

        let tf = field.textField
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textColor = .label
        tf.tintColor = .systemBlue
        tf.delegate = self
        tf.addTarget(self, action: #selector(fieldChanged(_:)), for: .editingChanged)
        container.addSubview(tf)

        var constraints = [
            field.label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: inset),
            field.label.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            field.label.heightAnchor.constraint(greaterThanOrEqualToConstant: 16),

            tf.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: inset),
            tf.topAnchor.constraint(equalTo: container.topAnchor, constant: 18),
            tf.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -bottomInset)
        ]

        if let rightView = rightView {
            container.addSubview(rightView)
            constraints += [
                rightView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
                rightView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
                rightView.widthAnchor.constraint(equalToConstant: 24),
                rightView.heightAnchor.constraint(equalToConstant: 24),
                tf.trailingAnchor.constraint(equalTo: rightView.leadingAnchor, constant: -8)
            ]
        } else {
            constraints.append(tf.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -inset))
        }

        NSLayoutConstraint.activate(constraints)
    }

    private func setupDOBField() {
        dobContainer.translatesAutoresizingMaskIntoConstraints = false
        dobContainer.layer.cornerRadius = 12
        dobContainer.layer.borderWidth = 1
        dobContainer.layer.borderColor = UIColor.systemGray4.cgColor
        dobContainer.backgroundColor = .secondarySystemBackground
        dobContainer.heightAnchor.constraint(equalToConstant: 56).isActive = true

        dobLabel.translatesAutoresizingMaskIntoConstraints = false
        dobLabel.text = "Date of Birth"
        dobLabel.font = .systemFont(ofSize: 13, weight: .regular)
        dobLabel.textColor = .secondaryLabel
        dobLabel.backgroundColor = .systemBackground
        dobLabel.layer.cornerRadius = 4
        dobLabel.layer.masksToBounds = true

        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        dateTextField.textColor = .label
        dateTextField.tintColor = .systemBlue
        dateTextField.delegate = self
        dateTextField.inputView = datePicker

        dobContainer.addSubview(dobLabel)
        dobContainer.addSubview(dateTextField)
        content.addArrangedSubview(dobContainer)

        NSLayoutConstraint.activate([
            dobLabel.leadingAnchor.constraint(equalTo: dobContainer.leadingAnchor, constant: 14),
            dobLabel.centerYAnchor.constraint(equalTo: dobContainer.centerYAnchor),
            dobLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16),

            dateTextField.leadingAnchor.constraint(equalTo: dobContainer.leadingAnchor, constant: 14),
            dateTextField.trailingAnchor.constraint(equalTo: dobContainer.trailingAnchor, constant: -14),
            dateTextField.topAnchor.constraint(equalTo: dobContainer.topAnchor, constant: 18),
            dateTextField.bottomAnchor.constraint(equalTo: dobContainer.bottomAnchor, constant: -10),
            dateTextField.heightAnchor.constraint(equalToConstant: 20)
        ])

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
        ]
        dateTextField.inputAccessoryView = toolbar
    }

    private func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.calendar = Calendar(identifier: .gregorian)
        datePicker.locale = Locale(identifier: "en_US_POSIX")
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }

    private func setupButton() {
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

    private func setupKeyboardHandling() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @objc private func keyboardWillChange(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue,
            let curveRaw = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue
        else { return }
        let curve = UIView.AnimationOptions(rawValue: curveRaw << 16)
        let overlap = max(0, view.bounds.maxY - view.convert(frame, from: nil).minY)
        UIView.animate(withDuration: duration, delay: 0, options: curve) {
            self.scrollView.contentInset.bottom = overlap + 12
            self.scrollView.verticalScrollIndicatorInsets.bottom = overlap + 12
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let field = fields.first(where: { $0.textField === textField }) {
            animate(field, focused: true)
        }
        if textField === dateTextField {
            animateDOB(focused: true)
        }
        let target: UIView = fields.first(where: { $0.textField === textField })?.container ?? (textField === dateTextField ? dobContainer : textField)
        DispatchQueue.main.async {
            let rect = target.convert(target.bounds, to: self.scrollView)
            self.scrollView.scrollRectToVisible(rect.insetBy(dx: 0, dy: -24), animated: true)
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let field = fields.first(where: { $0.textField === textField }) {
            animate(field, focused: false)
        }
        if textField === dateTextField {
            animateDOB(focused: false)
        }
        updateButtonState()
    }

    @objc private func doneTapped() {
        if dateTextField.isFirstResponder && selectedBirthDate == nil {
            dateChanged()
        }
        view.endEditing(true)
    }

    @objc private func editingBegan(_ sender: UITextField) {
        if let field = fields.first(where: { $0.textField === sender }) {
            animate(field, focused: true)
        }
    }

    @objc private func editingEnded(_ sender: UITextField) {
        if let field = fields.first(where: { $0.textField === sender }) {
            animate(field, focused: false)
        }
    }

    @objc private func fieldChanged(_ sender: UITextField) {
        if let field = fields.first(where: { $0.textField === sender }) {
            animate(field, focused: true)
        }
        updateButtonState()
    }

    @objc private func dateChanged() {
        selectedBirthDate = datePicker.date
        dateTextField.text = Self.dateFormatter.string(from: datePicker.date)
        animateDOB(focused: true)
        updateButtonState()
    }

    @objc private func togglePassword() {
        let tf = passwordField.textField
        let wasFirstResponder = tf.isFirstResponder
        let existingText = tf.text
        tf.isSecureTextEntry.toggle()
        passwordToggleButton.setImage(UIImage(systemName: tf.isSecureTextEntry ? "eye.slash" : "eye"), for: .normal)
        passwordToggleButton.tintColor = tf.isSecureTextEntry ? .tertiaryLabel : .label
        if wasFirstResponder {
            tf.becomeFirstResponder()
        }
        if let t = existingText, !t.isEmpty {
            tf.insertText("")
        }
    }

    @objc private func didTapSignUp() {
        view.endEditing(true)
        let email = emailField.trimmed
        let password = passwordField.trimmed
        let first = firstNameField.trimmed
        let last = lastNameField.trimmed

        guard Validator.isValidEmail(email) else { AlertManager.showInvalidEmailAlert(on: self); return }
        guard Validator.isValidPassword(password) else { AlertManager.showInvalidPasswordAlert(on: self); return }
        guard !first.isEmpty else { AlertManager.showInvalidUsernameAlert(on: self); return }
        guard !last.isEmpty else { AlertManager.showInvalidLastNameAlert(on: self); return }
        guard let birthDate = selectedBirthDate else { AlertManager.showInvalidDOBAlert(on: self); return }
        guard isOldEnough(birthDate) else { AlertManager.showBasicAlert(on: self, title: "Age Restriction", message: "You must be at least 16 years old."); return }

        let request = RegisterUserRequest(username: "", email: email, password: password, phone: "")
        setLoading(true)
        AuthService.shared.registerUser(with: request, firstName: first, lastName: last, birthDate: birthDate) { [weak self] success, error in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.setLoading(false)
                if let error = error {
                    AlertManager.showRegistrationErrorAlert(on: self, with: error)
                    return
                }
                guard success else {
                    AlertManager.showRegistrationErrorAlert(on: self)
                    return
                }
                self.navigationController?.pushViewController(MobileNumberVC(), animated: true)
            }
        }
    }

    private func isOldEnough(_ birthDate: Date) -> Bool {
        let minAgeYears = 16
        guard let minDate = Calendar(identifier: .gregorian).date(byAdding: .year, value: -minAgeYears, to: Date()) else { return true }
        return birthDate <= minDate
    }

    private func animate(_ field: FloatingField, focused: Bool) {
        let up = focused || field.hasText
        UIView.animate(withDuration: 0.22, delay: 0, options: [.curveEaseInOut]) {
            field.label.transform = up ? CGAffineTransform(translationX: 0, y: -18).scaledBy(x: 0.88, y: 0.88) : .identity
            field.label.textColor = up ? .tertiaryLabel : .secondaryLabel
        }
    }

    private func animateDOB(focused: Bool) {
        let hasText = !(dateTextField.text?.isEmpty ?? true)
        let up = focused || hasText
        UIView.animate(withDuration: 0.22) {
            self.dobLabel.transform = up ? CGAffineTransform(translationX: 0, y: -18).scaledBy(x: 0.88, y: 0.88) : .identity
            self.dobLabel.textColor = up ? .tertiaryLabel : .secondaryLabel
        }
    }

    private func updateButtonState() {
        let enabled = emailField.hasText && passwordField.hasText && firstNameField.hasText && lastNameField.hasText && selectedBirthDate != nil
        UIView.animate(withDuration: 0.22) {
            self.getStartedButton.isEnabled = enabled
            self.getStartedButton.backgroundColor = enabled ? .black : .systemGray4
        }
    }

    private func setLoading(_ loading: Bool) {
        getStartedButton.isEnabled = !loading
        getStartedButton.backgroundColor = loading ? .systemGray4 : .black
    }
}

#Preview {
    GetStartedVc()
}
