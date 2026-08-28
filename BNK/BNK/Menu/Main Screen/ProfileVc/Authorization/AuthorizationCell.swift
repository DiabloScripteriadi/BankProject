//
//  SettingsCell.swift
//  BNK
//
//  Created by chasemedkcorto on 06.02.26.
//
import UIKit
class AuthorizationCell: UITableViewCell {

    var onTap: (() -> Void)?

    private let authorzationPasswordButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .secondarySystemBackground
        btn.layer.masksToBounds = true
        btn.imageView?.contentMode = .scaleAspectFit
        btn.tintColor = .label
        
        if let image = UIImage(named: "notification") {
            btn.setImage(image, for: .normal)
        } else {
            
            btn.setImage(UIImage(systemName: "globe"), for: .normal)
        }
       
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.separator.cgColor
        return btn
    }()

    private let authorizeLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Authorization And Password"
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
        authorzationPasswordButton.layer.cornerRadius =  authorzationPasswordButton.bounds.height / 2
    }

    private func setupUi() {
        selectionStyle = .none
        contentView.backgroundColor = .systemBackground

        contentView.addSubview(authorzationPasswordButton)
        contentView.addSubview(authorizeLabel)

        NSLayoutConstraint.activate([
            authorzationPasswordButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            authorzationPasswordButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorzationPasswordButton.widthAnchor.constraint(equalToConstant: 60),
            authorzationPasswordButton.heightAnchor.constraint(equalToConstant: 60),

            authorizeLabel.centerYAnchor.constraint(equalTo: authorzationPasswordButton.centerYAnchor),
            authorizeLabel.leadingAnchor.constraint(equalTo: authorzationPasswordButton.trailingAnchor, constant: 12),
            authorizeLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),

            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: authorzationPasswordButton.bottomAnchor, constant: 0)
        ])

       
        authorzationPasswordButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        contentView.addGestureRecognizer(tap)
    }

    @objc private func handleTap() {
        onTap?()
    }
}
