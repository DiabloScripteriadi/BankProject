//
//  SettingsCell.swift
//  BNK
//
//  Created by chasemedkcorto on 06.02.26.
//

import UIKit
class AnalysisCell: UITableViewCell {

    var onTap: (() -> Void)?
   
    var ringWidth: CGFloat = 3 {
        didSet { setNeedsLayout() }
    }
    private let analysisButton: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular)
        imageView.image = UIImage(systemName: "chart.pie.fill")?.applyingSymbolConfiguration(config)
        imageView.tintColor = .systemBlue
        return imageView
    }()
    private let analysisLabel: UILabel = {
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
        v.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.15)
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
//        bonusButton.layer.cornerRadius = bonusButton.bounds.height / 2

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        CATransaction.commit()
    }


    private func setupUi() {
        selectionStyle = .none
        contentView.backgroundColor = .secondarySystemBackground

        contentView.addSubview(analysisButton)
        contentView.addSubview(analysisLabel)
        contentView.addSubview(iconBadgeView)
        NSLayoutConstraint.activate([
            iconBadgeView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            iconBadgeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            iconBadgeView.widthAnchor.constraint(equalToConstant: 25),
            iconBadgeView.heightAnchor.constraint(equalToConstant: 30),
        ])

        NSLayoutConstraint.activate([
            analysisButton.centerXAnchor.constraint(equalTo: iconBadgeView.centerXAnchor),
            analysisButton.centerYAnchor.constraint(equalTo: iconBadgeView.centerYAnchor),
            analysisButton.widthAnchor.constraint(equalToConstant: 18),
            analysisButton.heightAnchor.constraint(equalToConstant: 24),
            analysisButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 33),
            analysisButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
        NSLayoutConstraint.activate([

            analysisLabel.centerYAnchor.constraint(equalTo: analysisButton.centerYAnchor),
            analysisLabel.leadingAnchor.constraint(equalTo: analysisButton.trailingAnchor, constant: 16),
            analysisLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),

            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: analysisButton.bottomAnchor, constant: 0)
        ])
       
//        financialButton.addAction(UIAction(handler: { _ in
//            self.onTap?()
//        }), for: .touchUpInside)
    }
}


