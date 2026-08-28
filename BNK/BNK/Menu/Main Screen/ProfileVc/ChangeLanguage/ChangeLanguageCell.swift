//
//  SettingsCell.swift
//  BNK
//
//  Created by chasemedkcorto on 06.02.26.
//

import UIKit

class ChangeLanguageCell: UITableViewCell {

    var onTap: (() -> Void)?

    private let changeLanguageButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .secondarySystemBackground
        btn.layer.masksToBounds = true
        btn.imageView?.contentMode = .scaleAspectFit
        btn.tintColor = .label
        
        if let image = UIImage(named: "languages") {
            btn.setImage(image, for: .normal)
        } else {
            
            btn.setImage(UIImage(systemName: "globe"), for: .normal)
        }
       
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.separator.cgColor
        return btn
    }()

    private let changeLanguageLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Change Language"
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
        changeLanguageButton.layer.cornerRadius =  changeLanguageButton.bounds.height / 2
    }

    private func setupUi() {
        selectionStyle = .none
        contentView.backgroundColor = .systemBackground

        contentView.addSubview(changeLanguageButton)
        contentView.addSubview(changeLanguageLabel)

        NSLayoutConstraint.activate([
            changeLanguageButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            changeLanguageButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            changeLanguageButton.widthAnchor.constraint(equalToConstant: 60),
            changeLanguageButton.heightAnchor.constraint(equalToConstant: 60),

            changeLanguageLabel.centerYAnchor.constraint(equalTo: changeLanguageButton.centerYAnchor),
            changeLanguageLabel.leadingAnchor.constraint(equalTo: changeLanguageButton.trailingAnchor, constant: 12),
            changeLanguageLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),

            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: changeLanguageButton.bottomAnchor, constant: 0)
        ])

       
        changeLanguageButton.addAction(UIAction(handler:{_ in 
            self.onTap?()
        }), for: .touchUpInside  )
    }
}
