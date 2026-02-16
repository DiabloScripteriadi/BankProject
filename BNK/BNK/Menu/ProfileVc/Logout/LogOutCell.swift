        //
//  SettingsCell.swift
//  BNK
//
//  Created by chasemedkcorto on 06.02.26.
//
import UIKit
class LogOutCell: UITableViewCell {

    var onTap: (() -> Void)?

    private let logoutButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .secondarySystemBackground
        btn.layer.masksToBounds = true
        btn.imageView?.contentMode = .scaleAspectFit
        btn.tintColor = .label
        
        if let image = UIImage(named: "logout") {
            btn.setImage(image, for: .normal)
        } 
       
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.separator.cgColor
        return btn
    }()

    private let logoutLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "LogOut"
        lbl.font = .systemFont(ofSize: 16, weight: .medium)
        lbl.textColor = .label
        lbl.numberOfLines = 1
        return lbl
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUi()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        logoutButton.layer.cornerRadius =  logoutButton.bounds.height / 2
    }

    private func setupUi() {
        selectionStyle = .none
        contentView.backgroundColor = .systemBackground

        contentView.addSubview(logoutButton)
        contentView.addSubview(logoutLabel)

        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            logoutButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logoutButton.widthAnchor.constraint(equalToConstant: 60),
            logoutButton.heightAnchor.constraint(equalToConstant: 60),

            logoutLabel.centerYAnchor.constraint(equalTo: logoutButton.centerYAnchor),
            logoutLabel.leadingAnchor.constraint(equalTo: logoutButton.trailingAnchor, constant: 12),
            logoutLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),

            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: logoutButton.bottomAnchor, constant: 0)
        ])

       
        logoutButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        contentView.addGestureRecognizer(tap)
    }

    @objc private func handleTap() {
        onTap?()
    }
}
