//
//  SettingsCell.swift
//  BNK
//
//  Created by chasemedkcorto on 06.02.26.
//

import UIKit

class BonusCell: UITableViewCell {

    var onTap: (() -> Void)?
   
    var ringWidth: CGFloat = 3 {
        didSet { setNeedsLayout() }
    }
    private let bonusButton: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular)
        imageView.image = UIImage(systemName: "rosette")?.applyingSymbolConfiguration(config)
        imageView.tintColor = .purple
        return imageView
    }()
    private let bonusLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Bonus Program"
        lbl.font = .systemFont(ofSize: 16, weight: .medium)
        lbl.textColor = .label
        lbl.numberOfLines = 1
        return lbl
    }()
    private let iconBadgeView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.15)
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
        bonusButton.layer.cornerRadius = bonusButton.bounds.height / 2

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        CATransaction.commit()
    }


    private func setupUi() {
        selectionStyle = .none
        contentView.backgroundColor = .secondarySystemBackground

        contentView.addSubview(bonusButton)
        contentView.addSubview(bonusLabel)
        contentView.addSubview(iconBadgeView)
        NSLayoutConstraint.activate([
            iconBadgeView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            iconBadgeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            iconBadgeView.widthAnchor.constraint(equalToConstant: 25),
            iconBadgeView.heightAnchor.constraint(equalToConstant: 30),
        ])

        NSLayoutConstraint.activate([
            bonusButton.centerXAnchor.constraint(equalTo: iconBadgeView.centerXAnchor),
            bonusButton.centerYAnchor.constraint(equalTo: iconBadgeView.centerYAnchor),
            bonusButton.widthAnchor.constraint(equalToConstant: 18),
            bonusButton.heightAnchor.constraint(equalToConstant: 24),
            bonusButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 33),
            bonusButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
        NSLayoutConstraint.activate([

            bonusLabel.centerYAnchor.constraint(equalTo: bonusButton.centerYAnchor),
            bonusLabel.leadingAnchor.constraint(equalTo: bonusButton.trailingAnchor, constant: 16),
            bonusLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),

            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: bonusButton.bottomAnchor, constant: 0)
        ])
       
//        financialButton.addAction(UIAction(handler: { _ in
//            self.onTap?()
//        }), for: .touchUpInside)
    }
}
