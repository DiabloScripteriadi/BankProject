//
//  GetStartedVc.swift
//  BNK
//
//  Created by chasemedkcorto on 09.01.26.
//


import UIKit
import LocalAuthentication

class SecureVC: UIViewController {

    private let stepLabel = UILabel()
    private let divider = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    private let faceIDCard = UIControl()
    private let faceIDIconView = UIImageView()
    private let faceIDTitleLabel = UILabel()
    private let faceIDSubtitleLabel = UILabel()
    private let faceIDChevron = UIImageView()

    private let helperLabel = UILabel()
    private let getStartedButton = UIButton(type: .system)

    private var isFaceIDVerified = false {
        didSet {
            updateButtonState()
            updateCardState()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupStepLabel()
        setupDivider()
        setupTitleLabel()
        setupFaceIDCard()
        setupHelperLabel()
        setupGetStartedButton()
    }

    private func setupStepLabel() {
        stepLabel.translatesAutoresizingMaskIntoConstraints = false
        stepLabel.text = "Step 3/5"
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
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.text = "Secure Your Access"
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 0

        subtitleLabel.text = "Use Face ID to quickly and securely access your account."
        subtitleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.numberOfLines = 0

        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 28),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }

    private func setupFaceIDCard() {
        // Card container
        faceIDCard.translatesAutoresizingMaskIntoConstraints = false
        faceIDCard.backgroundColor = .secondarySystemBackground
        faceIDCard.layer.cornerRadius = 16
        faceIDCard.layer.shadowColor = UIColor.black.cgColor
        faceIDCard.layer.shadowOpacity = 0.06
        faceIDCard.layer.shadowOffset = CGSize(width: 0, height: 6)
        faceIDCard.layer.shadowRadius = 10

        // Icon
        let iconConfig = UIImage.SymbolConfiguration(pointSize: 28, weight: .semibold)
        faceIDIconView.translatesAutoresizingMaskIntoConstraints = false
        faceIDIconView.image = UIImage(systemName: "faceid", withConfiguration: iconConfig)
        faceIDIconView.tintColor = .label
        faceIDIconView.contentMode = .scaleAspectFit

        // Title
        faceIDTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        faceIDTitleLabel.text = "Face ID"
        faceIDTitleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        faceIDTitleLabel.textColor = .label
        faceIDTitleLabel.numberOfLines = 1

        // Subtitle
        faceIDSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        faceIDSubtitleLabel.text = "Authenticate using your device’s Face ID."
        faceIDSubtitleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        faceIDSubtitleLabel.textColor = .secondaryLabel
        faceIDSubtitleLabel.numberOfLines = 0

        // Chevron
        let chevronConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold)
        faceIDChevron.translatesAutoresizingMaskIntoConstraints = false
        faceIDChevron.image = UIImage(systemName: "chevron.right", withConfiguration: chevronConfig)
        faceIDChevron.tintColor = .tertiaryLabel
        faceIDChevron.contentMode = .scaleAspectFit

        view.addSubview(faceIDCard)
        faceIDCard.addSubview(faceIDIconView)
        faceIDCard.addSubview(faceIDTitleLabel)
        faceIDCard.addSubview(faceIDSubtitleLabel)
        faceIDCard.addSubview(faceIDChevron)

        NSLayoutConstraint.activate([
            faceIDCard.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 28),
            faceIDCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            faceIDCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            faceIDIconView.leadingAnchor.constraint(equalTo: faceIDCard.leadingAnchor, constant: 16),
            faceIDIconView.topAnchor.constraint(equalTo: faceIDCard.topAnchor, constant: 16),
            faceIDIconView.widthAnchor.constraint(equalToConstant: 36),
            faceIDIconView.heightAnchor.constraint(equalToConstant: 36),

            faceIDTitleLabel.leadingAnchor.constraint(equalTo: faceIDIconView.trailingAnchor, constant: 12),
            faceIDTitleLabel.topAnchor.constraint(equalTo: faceIDCard.topAnchor, constant: 16),
            faceIDTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: faceIDChevron.leadingAnchor, constant: -8),

            faceIDSubtitleLabel.leadingAnchor.constraint(equalTo: faceIDTitleLabel.leadingAnchor),
            faceIDSubtitleLabel.topAnchor.constraint(equalTo: faceIDTitleLabel.bottomAnchor, constant: 4),
            faceIDSubtitleLabel.trailingAnchor.constraint(equalTo: faceIDCard.trailingAnchor, constant: -16),
            faceIDSubtitleLabel.bottomAnchor.constraint(equalTo: faceIDCard.bottomAnchor, constant: -16),

            faceIDChevron.centerYAnchor.constraint(equalTo: faceIDTitleLabel.centerYAnchor),
            faceIDChevron.trailingAnchor.constraint(equalTo: faceIDCard.trailingAnchor, constant: -16),
            faceIDChevron.widthAnchor.constraint(equalToConstant: 12),
            faceIDChevron.heightAnchor.constraint(equalToConstant: 18)
        ])

        faceIDCard.addTarget(self, action: #selector(faceIDTapped), for: .touchUpInside)
    }

    private func setupHelperLabel() {
        helperLabel.translatesAutoresizingMaskIntoConstraints = false
        helperLabel.text = "You can change this later in Settings."
        helperLabel.font = .systemFont(ofSize: 13, weight: .regular)
        helperLabel.textColor = .tertiaryLabel
        helperLabel.numberOfLines = 0
        view.addSubview(helperLabel)

        NSLayoutConstraint.activate([
            helperLabel.topAnchor.constraint(equalTo: faceIDCard.bottomAnchor, constant: 12),
            helperLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            helperLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    private func setupGetStartedButton() {
        getStartedButton.translatesAutoresizingMaskIntoConstraints = false
        getStartedButton.setTitle("Continue", for: .normal)
        getStartedButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        getStartedButton.setTitleColor(.white, for: .normal)
        getStartedButton.backgroundColor = .systemGray4
        getStartedButton.layer.cornerRadius = 14
        getStartedButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        getStartedButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        view.addSubview(getStartedButton)

        NSLayoutConstraint.activate([
            getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getStartedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            getStartedButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 220),
            getStartedButton.heightAnchor.constraint(equalToConstant: 56)
        ])

        updateButtonState()
    }

    private func updateButtonState() {
        if isFaceIDVerified {
            getStartedButton.backgroundColor = .systemBlue
            getStartedButton.isEnabled = true
        } else {
            getStartedButton.backgroundColor = .systemGray4
            getStartedButton.isEnabled = false
        }
    }

    private func updateCardState() {

        UIView.animate(withDuration: 0.2) {
            self.faceIDCard.backgroundColor = self.isFaceIDVerified ? UIColor.systemBlue.withAlphaComponent(0.08) : .secondarySystemBackground
            self.faceIDIconView.tintColor = self.isFaceIDVerified ? .systemBlue : .label
            self.faceIDChevron.tintColor = self.isFaceIDVerified ? .systemBlue : .tertiaryLabel
        }
    }

    @objc private func faceIDTapped() {
        let context = LAContext()
        context.localizedFallbackTitle = ""
        var authError: NSError?
        let reason = "Authenticate with Face ID"

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, error in
                DispatchQueue.main.async {
                    self?.isFaceIDVerified = success
                }
                if !success, let error {
                    print("Face ID failed: \(error.localizedDescription)")
                }
            }
        } else {
            if let error = authError {
                print("Face ID unavailable: \(error.localizedDescription)")
            } else {
                print("Face ID unavailable for unknown reason.")
            }
        }
    }

    @objc private func continueTapped() {
         let vc = PasscodeVC()
         navigationController?.pushViewController(vc, animated: true)
    }
}
#warning("დავამატოთ ლოგინში როდესაც შეხვას დასეივებული პასკოდი მერე არ გაგიჭირდეება და ფეის აიდს გამოიყენებ შესავლელად ამაში კიჩეინი დაგვეხმარება")
