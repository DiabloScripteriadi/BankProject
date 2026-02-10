import UIKit
import CountryPickerView
import FirebaseAuth

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
        view.backgroundColor = .systemBackground

        setupStepLabel()
        setupDivider()
        setupTitleLabel()
        setupNumberField()
        setupGetStartedButton()
        setupCountryPicker()
        setupKeyboardToolbar()
        setupTapToDismiss()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        view.endEditing(true)
    }

    private func setupStepLabel() {
        stepLabel.translatesAutoresizingMaskIntoConstraints = false
        stepLabel.text = "Step 2/5"
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
            divider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35),
            divider.heightAnchor.constraint(equalToConstant: 4)
        ])
    }

    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Whats Your Phone Number?"
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

    private func setupNumberField() {
        numberContainer.translatesAutoresizingMaskIntoConstraints = false
        numberContainer.layer.cornerRadius = 12
        numberContainer.layer.borderWidth = 1
        numberContainer.layer.borderColor = UIColor.systemGray4.cgColor
        numberContainer.backgroundColor = .secondarySystemBackground
        view.addSubview(numberContainer)

        NSLayoutConstraint.activate([
            numberContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 28),
            numberContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            numberContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            numberContainer.heightAnchor.constraint(equalToConstant: 56)
        ])

        countryCodeButton.translatesAutoresizingMaskIntoConstraints = false
        countryCodeButton.setTitle("+1", for: .normal)
        countryCodeButton.setTitleColor(.label, for: .normal)
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
        numberFloatingLabel.font = .systemFont(ofSize: 13)
        numberFloatingLabel.textColor = .secondaryLabel
        numberFloatingLabel.backgroundColor = .systemBackground
        numberFloatingLabel.layer.cornerRadius = 4
        numberFloatingLabel.layer.masksToBounds = true
        numberContainer.addSubview(numberFloatingLabel)

        NSLayoutConstraint.activate([
            numberFloatingLabel.leadingAnchor.constraint(equalTo: countryCodeButton.trailingAnchor, constant: 8),
            numberFloatingLabel.centerYAnchor.constraint(equalTo: numberContainer.centerYAnchor),
            numberFloatingLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16)
        ])

        numberTextField.translatesAutoresizingMaskIntoConstraints = false
        numberTextField.keyboardType = .phonePad
        numberTextField.textColor = .label
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
        getStartedButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        getStartedButton.setTitleColor(.white, for: .normal)
        getStartedButton.backgroundColor = .systemGray4
        getStartedButton.layer.cornerRadius = 14
        getStartedButton.isEnabled = false
        getStartedButton.addTarget(self, action: #selector(getStartedTapped), for: .touchUpInside)
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

// gamoviyenet chatgpt dros ar davkargavdi

    private func setupKeyboardToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
        toolbar.items = [flex, done]
        numberTextField.inputAccessoryView = toolbar
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

    @objc private func getStartedTapped() {
        guard let rawNumber = numberTextField.text, !rawNumber.isEmpty else { return }
        let countryCode = countryCodeButton.title(for: .normal) ?? "+995"

        let cleanNumber = rawNumber
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "-", with: "")

        let phoneNumber = countryCode + cleanNumber

        print("📱 Trying phone number:", phoneNumber)


        getStartedButton.isEnabled = false
        getStartedButton.backgroundColor = .systemGray4

        
        getStartedButton.isEnabled = false


        AuthService.shared.startAuth(phoneNumber: phoneNumber) { [weak self] success in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if success {
                    print(" Verification ID generated!")
                    let vc = OTPVC()
                    self.navigationController!.pushViewController(vc, animated: true)
                } else {
                    print(" Failed to generate verification ID")
                    self.getStartedButton.isEnabled = true
                    self.getStartedButton.backgroundColor = .black
                }
            }
        }
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
#warning("gassasworebelia rodesac user wers textfieldshi chans tetrad textcolor shesacvlelia")
#warning("labels color shesacvlelia yvelgannn ")
