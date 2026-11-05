//
//  ProfileVC.swift
//  BNK
//
//  Created by chasemedkcorto on 30.01.26.
//
import UIKit
import SafariServices
import FirebaseAuth

final class ProfileVC: UIViewController {

    private let headerCard: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .secondarySystemBackground
        v.layer.cornerRadius = 26
        v.layer.cornerCurve = .continuous
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.separator.withAlphaComponent(0.35).cgColor
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.07
        v.layer.shadowOffset = CGSize(width: 0, height: 8)
        v.layer.shadowRadius = 14
        return v
    }()

    private let avatarCircle: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.14)
        v.layer.cornerRadius = 30
        v.layer.cornerCurve = .continuous
        return v
    }()

    private let avatarLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .systemFont(ofSize: 24, weight: .bold)
        lb.textColor = .systemBlue
        lb.textAlignment = .center
        return lb
    }()

    private let nameLabel: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 20, weight: .bold)
        lb.textColor = .label
        lb.text = "User"
        lb.lineBreakMode = .byTruncatingMiddle
        return lb
    }()

    private let emailLabel: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 14, weight: .regular)
        lb.textColor = .secondaryLabel
        lb.lineBreakMode = .byTruncatingMiddle
        return lb
    }()

    private lazy var nameStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [nameLabel, emailLabel])
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .vertical
        s.spacing = 3
        return s
    }()

    private let headerChevron: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "chevron.right"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .tertiaryLabel
        iv.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 14, weight: .bold)
        return iv
    }()

    private lazy var headerTap: UIControl = {
        let c = UIControl()
        c.translatesAutoresizingMaskIntoConstraints = false
        c.addTarget(self, action: #selector(didTapHeader), for: .touchUpInside)
        c.addTarget(self, action: #selector(headerDown), for: [.touchDown, .touchDragEnter])
        c.addTarget(self, action: #selector(headerUp), for: [.touchUpInside, .touchUpOutside, .touchCancel, .touchDragExit])
        return c
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = Metrics.spacing
        layout.minimumLineSpacing = Metrics.spacing
        layout.sectionInset = UIEdgeInsets(top: 16, left: Metrics.inset, bottom: 32, right: Metrics.inset)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.alwaysBounceVertical = true
        cv.showsVerticalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(ProfileCardCell.self, forCellWithReuseIdentifier: ProfileCardCell.reuseID)
        cv.register(ProfileLogoutCell.self, forCellWithReuseIdentifier: ProfileLogoutCell.reuseID)
        return cv
    }()

    private enum Metrics {
        static let inset: CGFloat = 16
        static let spacing: CGFloat = 12
    }

    private enum Row: Int, CaseIterable {
        case authorization
        case language
        case privacy
        case notifications
        case logout

        var title: String {
            switch self {
            case .authorization: return "Authorization & Password"
            case .language: return "Language"
            case .privacy: return "Security & Privacy"
            case .notifications: return "Notifications"
            case .logout: return "Log Out"
            }
        }

        var subtitle: String {
            switch self {
            case .authorization: return "Sign-in & security"
            case .language: return ""
            case .privacy: return "Policy & data"
            case .notifications: return "Manage alerts"
            case .logout: return ""
            }
        }

        var iconName: String {
            switch self {
            case .authorization: return "lock.shield.fill"
            case .language: return "globe"
            case .privacy: return "hand.raised.fill"
            case .notifications: return "bell.badge.fill"
            case .logout: return "rectangle.portrait.and.arrow.right"
            }
        }

        var tint: UIColor {
            switch self {
            case .authorization: return .systemBlue
            case .language: return .systemGreen
            case .privacy: return .systemOrange
            case .notifications: return .systemPurple
            case .logout: return .systemRed
            }
        }
    }

    private var currentLanguageName: String {
        switch UserDefaults.standard.string(forKey: "app.selectedLanguage") ?? "en" {
        case "ka": return "ქართული"
        case "ru": return "Русский"
        default: return "English"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .systemBackground
        setupLayout()
        refreshHeader()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshHeader()
        collectionView.reloadData()
    }

    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            self.collectionView.collectionViewLayout.invalidateLayout()
        })
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        headerCard.layer.borderColor = UIColor.separator.withAlphaComponent(0.35).cgColor
    }

    private func setupLayout() {
        view.addSubview(headerCard)
        headerCard.addSubview(avatarCircle)
        avatarCircle.addSubview(avatarLabel)
        headerCard.addSubview(nameStack)
        headerCard.addSubview(headerChevron)
        headerCard.addSubview(headerTap)
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            headerCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            headerCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.inset),
            headerCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metrics.inset),
            headerCard.heightAnchor.constraint(equalToConstant: 96),

            avatarCircle.leadingAnchor.constraint(equalTo: headerCard.leadingAnchor, constant: 18),
            avatarCircle.centerYAnchor.constraint(equalTo: headerCard.centerYAnchor),
            avatarCircle.widthAnchor.constraint(equalToConstant: 60),
            avatarCircle.heightAnchor.constraint(equalToConstant: 60),

            avatarLabel.centerXAnchor.constraint(equalTo: avatarCircle.centerXAnchor),
            avatarLabel.centerYAnchor.constraint(equalTo: avatarCircle.centerYAnchor),

            headerChevron.trailingAnchor.constraint(equalTo: headerCard.trailingAnchor, constant: -18),
            headerChevron.centerYAnchor.constraint(equalTo: headerCard.centerYAnchor),
            headerChevron.widthAnchor.constraint(equalToConstant: 12),
            headerChevron.heightAnchor.constraint(equalToConstant: 18),

            nameStack.leadingAnchor.constraint(equalTo: avatarCircle.trailingAnchor, constant: 14),
            nameStack.trailingAnchor.constraint(lessThanOrEqualTo: headerChevron.leadingAnchor, constant: -10),
            nameStack.centerYAnchor.constraint(equalTo: headerCard.centerYAnchor),

            headerTap.topAnchor.constraint(equalTo: headerCard.topAnchor),
            headerTap.leadingAnchor.constraint(equalTo: headerCard.leadingAnchor),
            headerTap.trailingAnchor.constraint(equalTo: headerCard.trailingAnchor),
            headerTap.bottomAnchor.constraint(equalTo: headerCard.bottomAnchor),

            collectionView.topAnchor.constraint(equalTo: headerCard.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func refreshHeader() {
        let user = Auth.auth().currentUser
        let displayName = (user?.displayName?.trimmingCharacters(in: .whitespacesAndNewlines))
            .flatMap { $0.isEmpty ? nil : $0 }
        let email = (user?.email?.trimmingCharacters(in: .whitespacesAndNewlines))
            .flatMap { $0.isEmpty ? nil : $0 }

        let primary = displayName ?? email ?? "User"
        nameLabel.text = primary
        emailLabel.text = displayName != nil ? (email ?? "") : ""
        emailLabel.isHidden = emailLabel.text?.isEmpty ?? true
        avatarLabel.text = primary.first.map { String($0).uppercased() } ?? "U"
    }

    @objc private func headerDown() {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState]) {
            self.headerCard.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
        }
    }

    @objc private func headerUp() {
        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.4,
                       options: [.allowUserInteraction, .beginFromCurrentState]) {
            self.headerCard.transform = .identity
        }
    }

    @objc private func didTapHeader() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()

        let ac = UIAlertController(title: "Profile", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Edit Profile (Coming Soon)", style: .default))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        if let pop = ac.popoverPresentationController {
            pop.sourceView = headerCard
            pop.sourceRect = headerCard.bounds
        }
        present(ac, animated: true)
    }

    private func openAuthorization() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        navigationController?.pushViewController(SecureVC(), animated: true)
    }

    private func openLanguagePicker() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()

        let selected = UserDefaults.standard.string(forKey: "app.selectedLanguage") ?? "en"

        let ac = UIAlertController(title: "Language",
                                   message: "Select app language",
                                   preferredStyle: .actionSheet)

        func addAction(title: String, code: String) {
            let actionTitle = (selected == code) ? "✓ \(title)" : title
            ac.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                UserDefaults.standard.set(code, forKey: "app.selectedLanguage")
                self.collectionView.reloadData()

                let toast = UIAlertController(title: nil,
                                              message: "Language set to \(title)",
                                              preferredStyle: .alert)
                self.present(toast, animated: true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                    toast.dismiss(animated: true)
                }
            }))
        }

        addAction(title: "English", code: "en")
        addAction(title: "ქართული", code: "ka")
        addAction(title: "Русский", code: "ru")

        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        if let pop = ac.popoverPresentationController {
            pop.sourceView = view
            pop.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 1, height: 1)
        }
        present(ac, animated: true)
    }

    private func openPrivacy() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        guard let url = URL(string: "https://www.apple.com/legal/privacy/") else { return }
        present(SFSafariViewController(url: url), animated: true)
    }

    private func openAppSettings() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        if let settingsURL = URL(string: UIApplication.openSettingsURLString),
           UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL)
        }
    }

    private func performLogout() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()

        AuthService.shared.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showLogoutError(on: self, with: error)
                return
            }
            if let sd = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sd.checkAuthentication()
            }
        }
    }
}

extension ProfileVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        Row.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let row = Row(rawValue: indexPath.item) else { return UICollectionViewCell() }

        if row == .logout {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileLogoutCell.reuseID,
                                                          for: indexPath) as! ProfileLogoutCell
            cell.configure(title: row.title, image: UIImage(systemName: row.iconName))
            return cell
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCardCell.reuseID,
                                                      for: indexPath) as! ProfileCardCell
        cell.configure(title: row.title,
                       subtitle: row == .language ? currentLanguageName : row.subtitle,
                       image: UIImage(systemName: row.iconName),
                       tint: row.tint)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let row = Row(rawValue: indexPath.item) else { return }
        switch row {
        case .authorization: openAuthorization()
        case .language: openLanguagePicker()
        case .privacy: openPrivacy()
        case .notifications: openAppSettings()
        case .logout: performLogout()
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let fullWidth = collectionView.bounds.width - Metrics.inset * 2

        if Row(rawValue: indexPath.item) == .logout {
            return CGSize(width: fullWidth, height: 72)
        }

        let width = floor((fullWidth - Metrics.spacing) / 2)
        return CGSize(width: width, height: width * 0.86)
    }
}
