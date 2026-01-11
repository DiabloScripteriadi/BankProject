//
//  GetStartedVc.swift
//  BNK
//
//  Created by chasemedkcorto on 11.01.26.
//
import UIKit

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

        return textField
    }()

    private let datePicker = UIDatePicker()
    private func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels

        datePicker.addTarget(self,action: #selector(dateChange(_:)),for: .valueChanged)
        datePicker.maximumDate = Date()
        dateTextfield.inputView = datePicker
    }

 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupDate()
        setupDatePicker()
        setupStepLabel()
        setupDivider()
        setupTitleLabel()
        setupMinyLabel()
        setupNameField()
        setupLastField()
        setupGetStartedButton()
    }


    private func setupStepLabel() {
        stepLabel.translatesAutoresizingMaskIntoConstraints = false
        stepLabel.text = "Step 4/5"
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
            divider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            divider.heightAnchor.constraint(equalToConstant: 4)
        ])
    }

    
    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Just a little bit more about yourself"
        titleLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        titleLabel.numberOfLines = 0
        view.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    private func setupMinyLabel() {
        minyLabel.translatesAutoresizingMaskIntoConstraints = false
        minyLabel.text = "We need some additional information from you to secure your account."
        minyLabel.font = .systemFont(ofSize: 14)
        minyLabel.textColor = .gray
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
        nameContainer.layer.cornerRadius = 10
        nameContainer.layer.borderWidth = 1
        nameContainer.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(nameContainer)

        NSLayoutConstraint.activate([
            nameContainer.topAnchor.constraint(equalTo: minyLabel.bottomAnchor, constant: 32),
            nameContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameContainer.heightAnchor.constraint(equalToConstant: 56)
        ])

        nameFloatingLabel.translatesAutoresizingMaskIntoConstraints = false
        nameFloatingLabel.text = "First Name"
        nameFloatingLabel.font = .systemFont(ofSize: 14)
        nameFloatingLabel.textColor = .gray
        nameFloatingLabel.backgroundColor = .white
        nameContainer.addSubview(nameFloatingLabel)

        nameTextfield.translatesAutoresizingMaskIntoConstraints = false
        nameTextfield.addTarget(self, action: #selector(nameChanged), for: .editingChanged)
        nameContainer.addSubview(nameTextfield)

        NSLayoutConstraint.activate([
            nameFloatingLabel.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor, constant: 12),
            nameFloatingLabel.centerYAnchor.constraint(equalTo: nameContainer.centerYAnchor),

            nameTextfield.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor, constant: 12),
            nameTextfield.trailingAnchor.constraint(equalTo: nameContainer.trailingAnchor, constant: -12),
            nameTextfield.topAnchor.constraint(equalTo: nameContainer.topAnchor, constant: 18),
            nameTextfield.bottomAnchor.constraint(equalTo: nameContainer.bottomAnchor, constant: -6)
        ])
    }


    private func setupLastField() {

        lastContainer.translatesAutoresizingMaskIntoConstraints = false
        lastContainer.layer.cornerRadius = 10
        lastContainer.layer.borderWidth = 1
        lastContainer.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(lastContainer)

        NSLayoutConstraint.activate([
            lastContainer.topAnchor.constraint(equalTo: nameContainer.bottomAnchor, constant: 20),
            lastContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lastContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            lastContainer.heightAnchor.constraint(equalToConstant: 56)
        ])

        lastFloatingLabel.translatesAutoresizingMaskIntoConstraints = false
        lastFloatingLabel.text = "Last Name"
        lastFloatingLabel.font = .systemFont(ofSize: 14)
        lastFloatingLabel.textColor = .gray
        lastFloatingLabel.backgroundColor = .white
        lastContainer.addSubview(lastFloatingLabel)

        lastTextfield.translatesAutoresizingMaskIntoConstraints = false
        lastTextfield.addTarget(self, action: #selector(lastChanged), for: .editingChanged)
        lastContainer.addSubview(lastTextfield)

        NSLayoutConstraint.activate([
            lastFloatingLabel.leadingAnchor.constraint(equalTo: lastContainer.leadingAnchor, constant: 12),
            lastFloatingLabel.centerYAnchor.constraint(equalTo: lastContainer.centerYAnchor),

            lastTextfield.leadingAnchor.constraint(equalTo: lastContainer.leadingAnchor, constant: 12),
            lastTextfield.trailingAnchor.constraint(equalTo: lastContainer.trailingAnchor, constant: -12),
            lastTextfield.topAnchor.constraint(equalTo: lastContainer.topAnchor, constant: 18),
            lastTextfield.bottomAnchor.constraint(equalTo: lastContainer.bottomAnchor, constant: -6)
        ])
    }

    private func setupGetStartedButton() {
        getStartedButton.translatesAutoresizingMaskIntoConstraints = false
        getStartedButton.setTitle("Get Started", for: .normal)
        getStartedButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        getStartedButton.setTitleColor(.white, for: .normal)
        getStartedButton.backgroundColor = .systemGray4
        getStartedButton.layer.cornerRadius = 14
        getStartedButton.isEnabled = false
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
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: Date())
        let age = ageComponents.year ?? 0
        dateTextfield.text = formatDate(date: birthDate)
    }


    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
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
        let enabled = !(nameTextfield.text?.isEmpty ?? true) &&
                      !(lastTextfield.text?.isEmpty ?? true)

        getStartedButton.isEnabled = enabled
        getStartedButton.backgroundColor = enabled ? .black : .systemGray4
    }
}
