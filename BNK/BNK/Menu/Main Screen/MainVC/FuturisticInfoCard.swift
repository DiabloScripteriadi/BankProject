//
//  FuturisticInfoCard.swift
//  BNK
//
//  Created by chasemedkcorto on 21.08.26.
//

import UIKit

final class FuturisticInfoCard: UIView {

    private let gradientLayer = CAGradientLayer()
    private let overlayLayer = CAGradientLayer()

    private let iconContainer = UIView()
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()

    private let bgColors: [UIColor]
    private let accentColors: [UIColor]

    init(
        title: String,
        value: String,
        symbolName: String,
        gradientColors: [UIColor],
        accentColors: [UIColor]
    ) {
        self.bgColors = gradientColors
        self.accentColors = accentColors
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false

        layer.cornerRadius = 20
        layer.cornerCurve = .continuous
        clipsToBounds = true

        // Background gradient
        gradientLayer.colors = bgColors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        layer.insertSublayer(gradientLayer, at: 0)

        // Subtle overlay gradient for depth
        overlayLayer.colors = accentColors.map { $0.withAlphaComponent(0.25).cgColor }
        overlayLayer.startPoint = CGPoint(x: 0, y: 0)
        overlayLayer.endPoint = CGPoint(x: 1, y: 0)
        layer.insertSublayer(overlayLayer, at: 1)

        // Icon container
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        iconContainer.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        iconContainer.layer.cornerRadius = 16
        iconContainer.layer.cornerCurve = .continuous

        // Icon
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.image = UIImage(systemName: symbolName)
        iconView.tintColor = .white
        iconView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 22, weight: .semibold)

        // Labels
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 13, weight: .medium)
        titleLabel.textColor = UIColor.white.withAlphaComponent(0.9)

        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 22, weight: .bold)
        valueLabel.textColor = .white

        addSubview(iconContainer)
        iconContainer.addSubview(iconView)
        addSubview(titleLabel)
        addSubview(valueLabel)

        NSLayoutConstraint.activate([
            iconContainer.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            iconContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            iconContainer.widthAnchor.constraint(equalToConstant: 44),
            iconContainer.heightAnchor.constraint(equalToConstant: 44),

            iconView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),

            titleLabel.topAnchor.constraint(equalTo: iconContainer.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -14),

            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            valueLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -14),
            valueLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -14)
        ])

        // Light border and shadow
        layer.borderColor = UIColor.white.withAlphaComponent(0.12).cgColor
        layer.borderWidth = 1.0 / UIScreen.main.scale

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.10
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 6)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        overlayLayer.frame = bounds
    }

    func update(title: String) { titleLabel.text = title }
    func update(value: String) { valueLabel.text = value }
    func update(symbolName: String) { iconView.image = UIImage(systemName: symbolName) }
}
