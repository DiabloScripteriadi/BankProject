//
//  ProfileVC.swift
//  BNK
//
//  Created by chasemedkcorto on 30.01.26.
//

import UIKit
import SwiftUI

class ProfileVC: UIViewController {

    
    private lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.dataSource = self
        tb.delegate = self
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.estimatedRowHeight = 0
        tb.backgroundColor = .systemBackground
        tb.register(AuthorizationCell.self, forCellReuseIdentifier: "AuthorizationCell")
        return tb
    }()

    private let profileBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .secondarySystemBackground
        btn.layer.cornerRadius = 20
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.darkGray.cgColor
        btn.clipsToBounds = true
        return btn
    }()

    private let avatarImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "person.circle"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .label
        iv.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 28, weight: .regular)
        return iv
    }()

    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "User"
        lbl.textColor = .label
        lbl.font = .systemFont(ofSize: 20, weight: .semibold)
        lbl.lineBreakMode = .byTruncatingMiddle
        return lbl
    }()

    private let chevronView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .tertiaryLabel
        iv.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold)
        iv.image = UIImage(systemName: "chevron.right")
        return iv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()

        // Add table below the profile button
        view.addSubview(tableView)
        setupTableView()

        profileBtn.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
    }

    private func setupUI() {
        view.addSubview(profileBtn)

        NSLayoutConstraint.activate([
            profileBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            profileBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            profileBtn.heightAnchor.constraint(equalToConstant: 80)
        ])

        profileBtn.addSubview(avatarImageView)
        profileBtn.addSubview(nameLabel)
        profileBtn.addSubview(chevronView)

        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: profileBtn.leadingAnchor, constant: 16),
            avatarImageView.centerYAnchor.constraint(equalTo: profileBtn.centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 32),
            avatarImageView.heightAnchor.constraint(equalToConstant: 32),

            chevronView.trailingAnchor.constraint(equalTo: profileBtn.trailingAnchor, constant: -16),
            chevronView.centerYAnchor.constraint(equalTo: profileBtn.centerYAnchor),
            chevronView.widthAnchor.constraint(equalToConstant: 12),
            chevronView.heightAnchor.constraint(equalToConstant: 18),

            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8),
            nameLabel.centerYAnchor.constraint(equalTo: profileBtn.centerYAnchor),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: chevronView.leadingAnchor, constant: -12)
        ])
    }

    private func setupTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: profileBtn.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func didTapProfile() {
        print("Profile row tapped")
    }
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Use the same identifier you registered
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
        return cell
    }
}

#Preview {
    UINavigationController(rootViewController: ProfileVC())
}
