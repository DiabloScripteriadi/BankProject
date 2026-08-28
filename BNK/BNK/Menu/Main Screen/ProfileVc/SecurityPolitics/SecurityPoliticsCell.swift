    //
//  SettingsCell.swift
//  BNK
//
//  Created by chasemedkcorto on 06.02.26.
//
import UIKit
class SecurityPoliticsCell: UITableViewCell {

    var onTap: (() -> Void)?

    private let securityPoliticsButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .secondarySystemBackground
        btn.layer.masksToBounds = true
        btn.imageView?.contentMode = .scaleAspectFit
        btn.tintColor = .label
        
        if let image = UIImage(named: "security") {
            btn.setImage(image, for: .normal)
        } else {
            
            btn.setImage(UIImage(systemName: "globe"), for: .normal)
        }
       
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.separator.cgColor
        return btn
    }()

    private let securityPoliticsLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Security And Politics"
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
        securityPoliticsButton.layer.cornerRadius =  securityPoliticsButton.bounds.height / 2
    }

    private func setupUi() {
        selectionStyle = .none
        contentView.backgroundColor = .systemBackground

        contentView.addSubview(securityPoliticsButton)
        contentView.addSubview(securityPoliticsLabel)

        NSLayoutConstraint.activate([
            securityPoliticsButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            securityPoliticsButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            securityPoliticsButton.widthAnchor.constraint(equalToConstant: 60),
            securityPoliticsButton.heightAnchor.constraint(equalToConstant: 60),

            securityPoliticsLabel.centerYAnchor.constraint(equalTo: securityPoliticsButton.centerYAnchor),
            securityPoliticsLabel.leadingAnchor.constraint(equalTo: securityPoliticsButton.trailingAnchor, constant: 12),
            securityPoliticsLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),

            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: securityPoliticsButton.bottomAnchor, constant: 0)
        ])

       
        securityPoliticsButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        contentView.addGestureRecognizer(tap)
    }

    @objc private func handleTap() {
        onTap?()
    }
}
