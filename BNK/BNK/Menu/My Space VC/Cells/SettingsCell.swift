//
//  SettingsCell.swift
//  BNK
//
//  Created by chasemedkcorto on 06.02.26.
//
//

import UIKit

class SettingsCell: UITableViewCell {

    var onTap: (() -> Void)?
   
    var ringWidth: CGFloat = 3 {
        didSet { setNeedsLayout() }
    }
    private let settingsButton: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular)
        imageView.image = UIImage(systemName: "gearshape.fill")?.applyingSymbolConfiguration(config)
        imageView.tintColor = .systemGray
        return imageView
    }()
    private let settingLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Settings"
        lbl.font = .systemFont(ofSize: 16, weight: .medium)
        lbl.textColor = .label
        lbl.numberOfLines = 1
        return lbl
    }()
    private let iconBadgeView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.systemGray.withAlphaComponent(0.15)
        v.layer.cornerRadius = 10
        return v
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
        settingsButton.layer.cornerRadius = settingsButton.bounds.height / 2

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        CATransaction.commit()
    }


    private func setupUi() {
        selectionStyle = .none
        contentView.backgroundColor = .secondarySystemBackground

        contentView.addSubview(settingsButton)
        contentView.addSubview(settingLabel)
        contentView.addSubview(iconBadgeView)
        NSLayoutConstraint.activate([
            iconBadgeView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            iconBadgeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            iconBadgeView.widthAnchor.constraint(equalToConstant: 25),
            iconBadgeView.heightAnchor.constraint(equalToConstant: 30),
        ])

        NSLayoutConstraint.activate([
            settingsButton.centerXAnchor.constraint(equalTo: iconBadgeView.centerXAnchor),
            settingsButton.centerYAnchor.constraint(equalTo: iconBadgeView.centerYAnchor),
            settingsButton.widthAnchor.constraint(equalToConstant: 18),
            settingsButton.heightAnchor.constraint(equalToConstant: 24),
            settingsButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 33),
            settingsButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
        NSLayoutConstraint.activate([

            settingLabel.centerYAnchor.constraint(equalTo: settingsButton.centerYAnchor),
            settingLabel.leadingAnchor.constraint(equalTo: settingsButton.trailingAnchor, constant: 16),
            settingLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),

            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: settingsButton.bottomAnchor, constant: 0)
        ])
       
//        financialButton.addAction(UIAction(handler: { _ in
//            self.onTap?()
//        }), for: .touchUpInside)
    }
}
