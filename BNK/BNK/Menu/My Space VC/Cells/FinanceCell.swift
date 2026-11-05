//
//  SettingsCell.swift
//  BNK
//
//  Created by chasemedkcorto on 06.02.26.
//

import UIKit

class FinanceCell: UITableViewCell {

    var onTap: (() -> Void)?
   
    var ringWidth: CGFloat = 3 {
        didSet { setNeedsLayout() }
    }
    private let financialButton: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular)
        imageView.image = UIImage(systemName: "target")?.applyingSymbolConfiguration(config)
        imageView.tintColor = .systemIndigo
        return imageView
    }()
    private let financialLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Financial Goals"
        lbl.font = .systemFont(ofSize: 16, weight: .medium)
        lbl.textColor = .label
        lbl.numberOfLines = 1
        return lbl
    }()
    private let iconBadgeView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.15)

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
        financialButton.layer.cornerRadius = financialButton.bounds.height / 2

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        CATransaction.commit()
    }


    private func setupUi() {
        selectionStyle = .none
        contentView.backgroundColor = .secondarySystemBackground

        contentView.addSubview(financialButton)
        contentView.addSubview(financialLabel)
        contentView.addSubview(iconBadgeView)
        NSLayoutConstraint.activate([
            iconBadgeView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            iconBadgeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            iconBadgeView.widthAnchor.constraint(equalToConstant: 25),
            iconBadgeView.heightAnchor.constraint(equalToConstant: 30),
        ])

        NSLayoutConstraint.activate([
            financialButton.centerXAnchor.constraint(equalTo: iconBadgeView.centerXAnchor),
            financialButton.centerYAnchor.constraint(equalTo: iconBadgeView.centerYAnchor),
            financialButton.widthAnchor.constraint(equalToConstant: 18),
            financialButton.heightAnchor.constraint(equalToConstant: 24),
            financialButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 33),
            financialButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
        NSLayoutConstraint.activate([

            financialLabel.centerYAnchor.constraint(equalTo: financialButton.centerYAnchor),
            financialLabel.leadingAnchor.constraint(equalTo: financialButton.trailingAnchor, constant: 16),
            financialLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),

            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: financialButton.bottomAnchor, constant: 0)
        ])
       
//        financialButton.addAction(UIAction(handler: { _ in
//            self.onTap?()
//        }), for: .touchUpInside)
    }
}

//import SwiftUI
//#Preview {
//    FinanceCell()
//}
