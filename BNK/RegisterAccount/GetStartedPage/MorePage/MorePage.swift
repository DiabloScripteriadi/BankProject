//
//  GetStartedVc.swift
//  BNK
//
//  Created by chasemedkcorto on 11.01.26.
//
import UIKit
import FirebaseAuth

class MoreVc: UIViewController {

    private let stepLabel = UILabel()
    private let divider = UIView()
    private let titleLabel = UILabel()
    private let minyLabel = UILabel()
    private let getStartedButton = UIButton(type: .system)

    private let nameContainer = UIView()
    private let nameTextfield = UITextField()
    private let nameFloatingLabel = UILabel()

    private let lastContainer = UIView()
    private let lastTextfield = UITextField()
    private let lastFloatingLabel = UILabel()
    
    private let dateTextfield: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Date of birth (YYYY-MM-DD)"
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        textField.tintColor = .systemBlue
        return textField
    }()

    private let datePicker = UIDatePicker()
    private var selectedBirthDate: Date?

    private func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(dateChange(_:)), for: .valueChanged)
        dateTextfield.inputView = datePicker
        addToolbar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupDate()
        setupDatePicker()
        setupStepLabel()
        setupDivider()
        setupTitleLabel()
        setupMinyLabel()
        setupNameField()
        setupLastField()
        setupGetStartedButton()

        nameTextfield.addTarget(self, action: #selector(nameChanged), for: .editingChanged)
        lastTextfield.addTarget(self, action: #selector(lastChanged), for: .editingChanged)
        dateTextfield.addTarget(self, action: #selector(dateTextChangedManually), for: .editingChanged)
    }

    private func setupStepLabel() {
        stepLabel.translatesAutoresizingMaskIntoConstraints = false
        stepLabel.text = "Step 4/5"
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
            divider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            divider.heightAnchor.constraint(equalToConstant: 4)
        ])
    }

    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Just a little bit more about yourself"
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

    private func setupMinyLabel() {
        minyLabel.translatesAutoresizingMaskIntoConstraints = false
        minyLabel.text = "We need some additional information from you to secure your account."
        minyLabel.font = .systemFont(ofSize: 16)
        minyLabel.textColor = .secondaryLabel
        minyLabel.numberOfLines = 0
        minyLabel.textAlignment = .center
        view.addSubview(minyLabel)

        NSLayoutConstraint.activate([
            minyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            minyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            minyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }

    private func setupNameField() {
        nameContainer.translatesAutoresizingMaskIntoConstraints = false
        nameContainer.layer.cornerRadius = 12
        nameContainer.layer.borderWidth = 1
        nameContainer.layer.borderColor = UIColor.systemGray4.cgColor
        nameContainer.backgroundColor = .secondarySystemBackground
        view.addSubview(nameContainer)

        NSLayoutConstraint.activate([
            nameContainer.topAnchor.constraint(equalTo: minyLabel.bottomAnchor, constant: 24),
            nameContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameContainer.heightAnchor.constraint(equalToConstant: 56)
        ])

        nameFloatingLabel.translatesAutoresizingMaskIntoConstraints = false
        nameFloatingLabel.text = "First Name"
        nameFloatingLabel.font = .systemFont(ofSize: 13)
        nameFloatingLabel.textColor = .secondaryLabel
        nameFloatingLabel.backgroundColor = .systemBackground
        nameFloatingLabel.layer.cornerRadius = 4
        nameFloatingLabel.layer.masksToBounds = true
        nameContainer.addSubview(nameFloatingLabel)

        nameTextfield.translatesAutoresizingMaskIntoConstraints = false
        nameContainer.addSubview(nameTextfield)

        NSLayoutConstraint.activate([
            nameFloatingLabel.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor, constant: 12),
            nameFloatingLabel.centerYAnchor.constraint(equalTo: nameContainer.centerYAnchor),
            nameFloatingLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16),

            nameTextfield.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor, constant: 12),
            nameTextfield.trailingAnchor.constraint(equalTo: nameContainer.trailingAnchor, constant: -12),
            nameTextfield.topAnchor.constraint(equalTo: nameContainer.topAnchor, constant: 18),
            nameTextfield.bottomAnchor.constraint(equalTo: nameContainer.bottomAnchor, constant: -6)
        ])
    }

    private func setupLastField() {
        lastContainer.translatesAutoresizingMaskIntoConstraints = false
        lastContainer.layer.cornerRadius = 12
        lastContainer.layer.borderWidth = 1
        lastContainer.layer.borderColor = UIColor.systemGray4.cgColor
        lastContainer.backgroundColor = .secondarySystemBackground
        view.addSubview(lastContainer)

        NSLayoutConstraint.activate([
            lastContainer.topAnchor.constraint(equalTo: nameContainer.bottomAnchor, constant: 16),
            lastContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lastContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            lastContainer.heightAnchor.constraint(equalToConstant: 56)
        ])

        lastFloatingLabel.translatesAutoresizingMaskIntoConstraints = false
        lastFloatingLabel.text = "Last Name"
        lastFloatingLabel.font = .systemFont(ofSize: 13)
        lastFloatingLabel.textColor = .secondaryLabel
        lastFloatingLabel.backgroundColor = .systemBackground
        lastFloatingLabel.layer.cornerRadius = 4
        lastFloatingLabel.layer.masksToBounds = true
        lastContainer.addSubview(lastFloatingLabel)

        lastTextfield.translatesAutoresizingMaskIntoConstraints = false
        lastContainer.addSubview(lastTextfield)

        NSLayoutConstraint.activate([
            lastFloatingLabel.leadingAnchor.constraint(equalTo: lastContainer.leadingAnchor, constant: 12),
            lastFloatingLabel.centerYAnchor.constraint(equalTo: lastContainer.centerYAnchor),
            lastFloatingLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16),

            lastTextfield.leadingAnchor.constraint(equalTo: lastContainer.leadingAnchor, constant: 12),
            lastTextfield.trailingAnchor.constraint(equalTo: lastContainer.trailingAnchor, constant: -12),
            lastTextfield.topAnchor.constraint(equalTo: lastContainer.topAnchor, constant: 18),
            lastTextfield.bottomAnchor.constraint(equalTo: lastContainer.bottomAnchor, constant: -6)
        ])
    }

    private func setupGetStartedButton() {
        getStartedButton.translatesAutoresizingMaskIntoConstraints = false
        getStartedButton.setTitle("Continue", for: .normal)
        getStartedButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        getStartedButton.setTitleColor(.white, for: .normal)
        getStartedButton.backgroundColor = .systemGray4
        getStartedButton.layer.cornerRadius = 14
        getStartedButton.isEnabled = false
        getStartedButton.addTarget(self, action: #selector(saveProfile), for: .touchUpInside)
        view.addSubview(getStartedButton)

        NSLayoutConstraint.activate([
            getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getStartedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            getStartedButton.widthAnchor.constraint(equalToConstant: 300),
            getStartedButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }

    private func setupDate() {
        view.addSubview(dateTextfield)
        dateTextfield.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            dateTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dateTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dateTextfield.topAnchor.constraint(equalTo: view.topAnchor, constant: 480),
            dateTextfield.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    @objc func dateChange(_ sender: UIDatePicker) {
        let birthDate = sender.date
        selectedBirthDate = birthDate
        dateTextfield.text = formatDate(date: birthDate)
        updateButtonState()
    }

    @objc private func dateTextChangedManually() {
        // თუ მომხმარებელმა manual-ად ჩაწერა, ვცდილობთ დავპარსოთ
        if let text = dateTextfield.text, let parsed = parseDate(from: text) {
            selectedBirthDate = parsed
        } else {
            selectedBirthDate = nil
        }
        updateButtonState()
    }

    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: date)
    }

    func parseDate(from string: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.date(from: string)
    }

    private func addToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
        toolbar.setItems([doneButton], animated: false)
        dateTextfield.inputAccessoryView = toolbar
    }

    @objc private func doneTapped() {
        view.endEditing(true)
    }
    
    @objc private func nameChanged() {
        animate(label: nameFloatingLabel, hasText: !(nameTextfield.text?.isEmpty ?? true))
        updateButtonState()
    }

    @objc private func lastChanged() {
        animate(label: lastFloatingLabel, hasText: !(lastTextfield.text?.isEmpty ?? true))
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
        let hasFirst = !(nameTextfield.text?.isEmpty ?? true)
        let hasLast = !(lastTextfield.text?.isEmpty ?? true)
        let hasDOB = selectedBirthDate != nil || !(dateTextfield.text?.isEmpty ?? true)
        let enabled = hasFirst && hasLast && hasDOB

        getStartedButton.isEnabled = enabled
        getStartedButton.backgroundColor = enabled ? .black : .systemGray4
    }

    @objc private func saveProfile() {
        let first = nameTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let last = lastTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        var birthDate: Date?
        let email = UserDefaults.standard.string(forKey: "email") ?? ""
        if let selected = selectedBirthDate {
            birthDate = selected
        } else if let text = dateTextfield.text, let parsed = parseDate(from: text) {
            birthDate = parsed
        }

        guard !first.isEmpty else {
            AlertManager.showInvalidUsernameAlert(on: self)
            return
        }
        guard !last.isEmpty else {
            AlertManager.showBasicAlert(on: self, title: "Invalid Last Name", message: "Please enter your last name.")
            return
        }
        guard let dob = birthDate else {
            AlertManager.showBasicAlert(on: self, title: "Invalid Date of Birth", message: "Please select your birth date.")
            return
        }

      
         let years = Calendar.current.dateComponents([.year], from: dob, to: Date()).year ?? 0
         if years < 13 {
             print("patara asakisaa")
             
         }
        //დლოგინებული უნდა იყო ჩატ ჯიპის გავაკეთებინე ეს ფრაზა
        guard Auth.auth().currentUser != nil else {
            AlertManager.showBasicAlert(on: self, title: "Not Authenticated", message: "Please sign in again.")
            return
        }

        AuthService.shared.updateUserProfile(email: email, username: first, lastName: last, birthDate: dob) { [weak self] success, error in
            guard let self = self else { return }

            if let error = error {
                AlertManager.showRegistrationErrorAlert(on: self, with: error)
                return
            }
            if success {
                 let vc = LoadingVc()
                self.navigationController?.pushViewController(vc, animated: true)
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                AlertManager.showRegistrationErrorAlert(on: self)
            }
        }
    }
}
#warning("loading screen gaqvs gasaketebili romelic loadings moaxdens da gadava onboard screenze figmaze gadaamowme fetchavs datas")
#warning("Forgot Pasword Page gasaketebeli")
#warning("Design Dasaxvewi divider asatani yvelag page ze da gadasanawilebeli")
