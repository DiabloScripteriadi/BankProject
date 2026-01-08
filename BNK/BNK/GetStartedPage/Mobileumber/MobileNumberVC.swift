//
//  MobileNumberVC.swift
//  BNK(Bog)
//
//  Created by chasemedkcorto on 08.01.26.
//

import UIKit
import CountryPickerView

final class MobileNumberVC: UIViewController {



    private let stepLabel = UILabel()
    private let divider = UIView()
    private let titleLabel = UILabel()

    private let numberContainer = UIView()
    private let countryCodeButton = UIButton(type: .system)
    private let numberTextField = UITextField()
    private let numberFloatingLabel = UILabel()

    private let getStartedButton = UIButton(type: .system)

    private let countryPickerView = CountryPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupStepLabel()
        setupDivider()
        setupTitleLabel()
        setupNumberField()
        setupGetStartedButton()
        setupCountryPicker()
    }
    private func setupStepLabel() {
        stepLabel.translatesAutoresizingMaskIntoConstraints = false
        stepLabel.text = "Step 2/5"
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
        divider.layer.cornerRadius = 2.5
        view.addSubview(divider)

        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: stepLabel.bottomAnchor, constant: 8),
            divider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            divider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            divider.heightAnchor.constraint(equalToConstant: 5)
        ])
    }

    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Whats Your Phone Number?"
        titleLabel.font = .systemFont(ofSize: 25, weight: .semibold)
        titleLabel.numberOfLines = 0
        view.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 35),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    private func setupNumberField() {
        numberContainer.translatesAutoresizingMaskIntoConstraints = false
        numberContainer.layer.cornerRadius = 12
        numberContainer.layer.borderWidth = 1
        numberContainer.layer.borderColor = UIColor.systemGray3.cgColor
        view.addSubview(numberContainer)

        NSLayoutConstraint.activate([
            numberContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            numberContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            numberContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            numberContainer.heightAnchor.constraint(equalToConstant: 56)
        ])

        countryCodeButton.translatesAutoresizingMaskIntoConstraints = false
        countryCodeButton.setTitle("+1", for: .normal)
        countryCodeButton.setTitleColor(.black, for: .normal)
        countryCodeButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        countryCodeButton.addTarget(self, action: #selector(openCountryPicker), for: .touchUpInside)
        numberContainer.addSubview(countryCodeButton)

        NSLayoutConstraint.activate([
            countryCodeButton.leadingAnchor.constraint(equalTo: numberContainer.leadingAnchor, constant: 12),
            countryCodeButton.centerYAnchor.constraint(equalTo: numberContainer.centerYAnchor),
            countryCodeButton.widthAnchor.constraint(equalToConstant: 60)
        ])

        numberFloatingLabel.translatesAutoresizingMaskIntoConstraints = false
        numberFloatingLabel.text = "Phone Number"
        numberFloatingLabel.font = .systemFont(ofSize: 14)
        numberFloatingLabel.textColor = .gray
        numberContainer.addSubview(numberFloatingLabel)

        NSLayoutConstraint.activate([
            numberFloatingLabel.leadingAnchor.constraint(equalTo: countryCodeButton.trailingAnchor, constant: 8),
            numberFloatingLabel.centerYAnchor.constraint(equalTo: numberContainer.centerYAnchor)
        ])

        numberTextField.translatesAutoresizingMaskIntoConstraints = false
        numberTextField.keyboardType = .phonePad
        numberTextField.addTarget(self, action: #selector(numberChanged), for: .editingChanged)
        numberTextField.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        numberContainer.addSubview(numberTextField)

        NSLayoutConstraint.activate([
            numberTextField.leadingAnchor.constraint(equalTo: countryCodeButton.trailingAnchor, constant: 8),
            numberTextField.trailingAnchor.constraint(equalTo: numberContainer.trailingAnchor, constant: -12),
            numberTextField.topAnchor.constraint(equalTo: numberContainer.topAnchor, constant: 18),
            numberTextField.bottomAnchor.constraint(equalTo: numberContainer.bottomAnchor, constant: -8)
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

    private func setupCountryPicker() {
        countryPickerView.delegate = self
        
    }


    @objc private func openCountryPicker() {
        countryPickerView.showCountriesList(from: self)
    }

    @objc private func editingDidBegin() {
        animateFloatingLabel(up: true)
    }

    @objc private func numberChanged() {
        let hasText = !(numberTextField.text?.isEmpty ?? true)
        animateFloatingLabel(up: hasText)
        updateButtonState()
    }

    private func animateFloatingLabel(up: Bool) {
        UIView.animate(withDuration: 0.25) {
            self.numberFloatingLabel.transform = up
                ? CGAffineTransform(translationX: 0, y: -18).scaledBy(x: 0.85, y: 0.85)
                : .identity
        }
    }

    private func updateButtonState() {
        let enabled = !(numberTextField.text?.isEmpty ?? true)
        getStartedButton.isEnabled = enabled
        getStartedButton.backgroundColor = enabled ? .black : .systemGray4
    }
}



extension MobileNumberVC: CountryPickerViewDelegate {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        countryCodeButton.setTitle("\(country.phoneCode)", for: .normal)
    }
}
