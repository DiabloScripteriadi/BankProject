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

    // MARK: - UI

    private let headerCard: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .secondarySystemBackground
        v.layer.cornerRadius = 20
        v.layer.cornerCurve = .continuous
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.separator.cgColor
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.06
        v.layer.shadowOffset = CGSize(width: 0, height: 6)
        v.layer.shadowRadius = 10
        return v
    }()

    private let avatarView: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "person.circle"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .label
        iv.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 36, weight: .regular)
        return iv
    }()

    private let nameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .systemFont(ofSize: 20, weight: .semibold)
        lb.textColor = .label
        lb.text = "User"
        lb.lineBreakMode = .byTruncatingMiddle
        return lb
    }()

    private let emailLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .systemFont(ofSize: 13, weight: .regular)
        lb.textColor = .secondaryLabel
        lb.text = ""
        lb.lineBreakMode = .byTruncatingMiddle
        return lb
    }()

    private let headerChevron: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "chevron.right"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .tertiaryLabel
        iv.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold)
        return iv
    }()

    private lazy var headerTap: UIControl = {
        let c = UIControl()
        c.translatesAutoresizingMaskIntoConstraints = false
        c.addTarget(self, action: #selector(didTapHeader), for: .touchUpInside)
        return c
    }()

    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .systemBackground
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 24, right: 0)
        tv.register(ProfileRowCell.self, forCellReuseIdentifier: ProfileRowCell.reuseID)
        return tv
    }()

    // MARK: - Data

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

        var iconName: String {
            switch self {
            case .authorization: return "lock.shield"
            case .language: return "globe"
            case .privacy: return "shield.lefthalf.filled"
            case .notifications: return "bell.badge"
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

        var showsChevron: Bool {
            return self != .logout
        }
    }

    // MARK: - Lifecycle

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
        tableView.reloadData()
    }

    // MARK: - Layout

    private func setupLayout() {
        view.addSubview(headerCard)
        headerCard.addSubview(avatarView)
        headerCard.addSubview(nameLabel)
        headerCard.addSubview(emailLabel)
        headerCard.addSubview(headerChevron)
        headerCard.addSubview(headerTap)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            headerCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            headerCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            headerCard.heightAnchor.constraint(equalToConstant: 96),

            avatarView.leadingAnchor.constraint(equalTo: headerCard.leadingAnchor, constant: 16),
            avatarView.centerYAnchor.constraint(equalTo: headerCard.centerYAnchor),
            avatarView.widthAnchor.constraint(equalToConstant: 40),
            avatarView.heightAnchor.constraint(equalToConstant: 40),

            headerChevron.trailingAnchor.constraint(equalTo: headerCard.trailingAnchor, constant: -14),
            headerChevron.centerYAnchor.constraint(equalTo: headerCard.centerYAnchor),
            headerChevron.widthAnchor.constraint(equalToConstant: 12),
            headerChevron.heightAnchor.constraint(equalToConstant: 18),

            nameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: headerChevron.leadingAnchor, constant: -8),
            nameLabel.bottomAnchor.constraint(equalTo: headerCard.centerYAnchor, constant: -2),

            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            emailLabel.trailingAnchor.constraint(lessThanOrEqualTo: headerChevron.leadingAnchor, constant: -8),
            emailLabel.topAnchor.constraint(equalTo: headerCard.centerYAnchor, constant: 2),

            headerTap.topAnchor.constraint(equalTo: headerCard.topAnchor),
            headerTap.leadingAnchor.constraint(equalTo: headerCard.leadingAnchor),
            headerTap.trailingAnchor.constraint(equalTo: headerCard.trailingAnchor),
            headerTap.bottomAnchor.constraint(equalTo: headerCard.bottomAnchor),

            tableView.topAnchor.constraint(equalTo: headerCard.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - Header

    private func refreshHeader() {
        let user = Auth.auth().currentUser
        let displayName = (user?.displayName?.trimmingCharacters(in: .whitespacesAndNewlines)).flatMap { $0.isEmpty ? nil : $0 }
        let email = (user?.email?.trimmingCharacters(in: .whitespacesAndNewlines)).flatMap { $0.isEmpty ? nil : $0 }

        nameLabel.text = displayName ?? email ?? "User"
        emailLabel.text = displayName != nil ? (email ?? "") : ""
        emailLabel.isHidden = emailLabel.text?.isEmpty ?? true
    }

    // MARK: - Actions

    @objc private func didTapHeader() {
        let h = UIImpactFeedbackGenerator(style: .light)
        h.impactOccurred()

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
        let h = UIImpactFeedbackGenerator(style: .light)
        h.impactOccurred()
        let vc = SecureVC()
        navigationController?.pushViewController(vc, animated: true)
    }

    private func openLanguagePicker() {
        let h = UIImpactFeedbackGenerator(style: .light)
        h.impactOccurred()

        let selected = UserDefaults.standard.string(forKey: "app.selectedLanguage")

        let ac = UIAlertController(title: "Language",
                                   message: "Select app language",
                                   preferredStyle: .actionSheet)

        func addAction(title: String, code: String) {
            let isSelected = (selected == code)
            let actionTitle = isSelected ? "✓ \(title)" : title
            ac.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { _ in
                UserDefaults.standard.set(code, forKey: "app.selectedLanguage")
                let toast = UIAlertController(title: nil, message: "Language set to \(title)", preferredStyle: .alert)
                self.present(toast, animated: true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                    toast.dismiss(animated: true)
                }
                self.tableView.reloadData()
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
        let h = UIImpactFeedbackGenerator(style: .light)
        h.impactOccurred()

        // Replace with your real policy URL
        guard let url = URL(string: "https://www.apple.com/legal/privacy/") else { return }
        let safari = SFSafariViewController(url: url)
        present(safari, animated: true)
    }

    private func openAppSettings() {
        let h = UIImpactFeedbackGenerator(style: .light)
        h.impactOccurred()

        if let settingsURL = URL(string: UIApplication.openSettingsURLString),
           UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL)
        }
    }

    private func performLogout() {
        let h = UIImpactFeedbackGenerator(style: .light)
        h.impactOccurred()

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

// MARK: - UITableView

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Row.allCases.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = Row(rawValue: indexPath.row) else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileRowCell.reuseID, for: indexPath) as! ProfileRowCell

        let subtitle: String? = {
            switch row {
            case .language:
                let code = UserDefaults.standard.string(forKey: "app.selectedLanguage") ?? "en"
                switch code {
                case "en": return "English"
                case "ka": return "ქართული"
                case "ru": return "Русский"
                default: return nil
                }
            default:
                return nil
            }
        }()

        cell.configure(
            iconSystemName: row.iconName,
            tint: row.tint,
            title: row.title,
            subtitle: subtitle,
            showsChevron: row.showsChevron
        )
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let row = Row(rawValue: indexPath.row) else { return }

        switch row {
        case .authorization: openAuthorization()
        case .language: openLanguagePicker()
        case .privacy: openPrivacy()
        case .notifications: openAppSettings()
        case .logout: performLogout()
        }
    }

    // Spacing between card rows
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        64
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        8
    }
}
