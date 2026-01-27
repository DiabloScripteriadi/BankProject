//
//  PasscodeRepeatVC 2.swift
//  BNK
//
//  Created by chasemedkcorto on 14.01.26.
//


import UIKit

class LoginPasscodeVC: UIViewController {

    private let stepLabel = UILabel()
    private let divider = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let stackView = UIStackView()
    private let getStartedButton = UIButton(type: .system)

    private let maxDigits = 5
    private var enteredDigits: [Int] = []

    private let dotsStackView = UIStackView()
    private var dotViews: [UIView] = []

    private let keypadStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupStepLabel()
        setupDivider()
        setupTitleLabel()
        setupStackViewLabels()
        setupDots()
        setupKeypad()
        setupGetStartedButton()
    }

    private func setupStepLabel() {
        stepLabel.translatesAutoresizingMaskIntoConstraints = false
        stepLabel.text = "Step 2/2"
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
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.text = "Enter Your Passcode"
        titleLabel.font = .systemFont(ofSize: 25, weight: .semibold)
        titleLabel.numberOfLines = 0

        subtitleLabel.text = ""
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.textColor = .gray
        subtitleLabel.numberOfLines = 0

        view.addSubview(titleLabel)
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

    private func setupStackViewLabels() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 56)
        ])
    }

    private func setupDots() {
        dotsStackView.axis = .horizontal
        dotsStackView.spacing = 10
        dotsStackView.alignment = .center
        dotsStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dotsStackView)

        for _ in 0..<maxDigits {
            let dot = UIView()
            dot.backgroundColor = .lightGray
            dot.layer.cornerRadius = 6
            dot.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                dot.widthAnchor.constraint(equalToConstant: 12),
                dot.heightAnchor.constraint(equalToConstant: 12)
            ])

            dotsStackView.addArrangedSubview(dot)
            dotViews.append(dot)
        }

        NSLayoutConstraint.activate([
            dotsStackView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 40),
            dotsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setupKeypad() {
        keypadStackView.axis = .vertical
        keypadStackView.spacing = 14
        keypadStackView.alignment = .center
        keypadStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keypadStackView)

        let numbers: [[Any]] = [
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9],
            [ 0, "⌫",]
        ]

        for row in numbers {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 14
            rowStack.distribution = .fillEqually

            for item in row {
                let button = createButton(title: "\(item)")
                rowStack.addArrangedSubview(button)
            }

            keypadStackView.addArrangedSubview(rowStack)
        }

        NSLayoutConstraint.activate([
            keypadStackView.topAnchor.constraint(equalTo: dotsStackView.bottomAnchor, constant: 40),
            keypadStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }


    private func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .medium)
        button.backgroundColor = .tertiarySystemBackground
        button.layer.cornerRadius = 35
        button.layer.borderWidth = 2
        button.titleLabel?.textColor = .black
        button.layer.borderColor = UIColor.gray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 70),
            button.heightAnchor.constraint(equalToConstant: 70)
        ])

        button.addTarget(self, action: #selector(numberTapped(_:)), for: .touchUpInside)
        return button
    }

    @objc private func numberTapped(_ sender: UIButton) {
        guard let text = sender.titleLabel?.text else { return }

        if text == "⌫" {
            guard !enteredDigits.isEmpty else { return }
            enteredDigits.removeLast()
            getStartedButton.isEnabled = false
            getStartedButton.backgroundColor = .systemGray4
            updateDots()
            return
        }

        guard let number = Int(text),
              enteredDigits.count < maxDigits else { return }

        enteredDigits.append(number)
        updateDots()

        if enteredDigits.count == maxDigits {
            getStartedButton.isEnabled = true
            getStartedButton.backgroundColor = .systemBlue
        }
    }


    private func updateDots() {
        for (index, dot) in dotViews.enumerated() {
            dot.backgroundColor = index < enteredDigits.count ? .black : .lightGray
        }
    }

    private func setupGetStartedButton() {
        getStartedButton.translatesAutoresizingMaskIntoConstraints = false
        getStartedButton.setTitle("Verify", for: .normal)
        getStartedButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        getStartedButton.setTitleColor(.white, for: .normal)
        getStartedButton.backgroundColor = .systemGray4
        getStartedButton.layer.cornerRadius = 15
        getStartedButton.isEnabled = false
        getStartedButton.addTarget(self, action: #selector(DidTapLogout), for: .touchUpInside)
        view.addSubview(getStartedButton)

        NSLayoutConstraint.activate([
            getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getStartedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            getStartedButton.widthAnchor.constraint(equalToConstant: 300),
            getStartedButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    @objc func DidTapLogout() {
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showLogoutError(on: self, with: error)
                return
            }
            if let sceneDelegate = self.view.window?.windowScene?.delegate  as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
   
   }

#warning("pascode shi gadasatani delete gilaki 0 ianis adginlas da gasadidbeli")

