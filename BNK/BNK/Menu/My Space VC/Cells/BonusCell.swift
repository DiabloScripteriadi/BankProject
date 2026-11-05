//
//  SettingsCell.swift
//  BNK
//
//  Created by chasemedkcorto on 06.02.26.
//

import UIKit

class BonusCell: UITableViewCell {

    var onTap: (() -> Void)?
    var ringColors: [UIColor] = [
        UIColor(red: 0.36, green: 0.31, blue: 0.91, alpha: 1),  // indigo
        UIColor(red: 0.13, green: 0.78, blue: 0.69, alpha: 1),  // teal
        UIColor(red: 0.95, green: 0.72, blue: 0.29, alpha: 1),  // gold
    ] {
        didSet { updateRingColors() }
    }
    var ringWidth: CGFloat = 3 {
        didSet { setNeedsLayout() }
    }

    private let gradientRingLayer = CAGradientLayer()
    private let ringMask = CAShapeLayer()

    private let bonusButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .secondarySystemBackground
        btn.layer.masksToBounds = true
        btn.imageView?.contentMode = .scaleAspectFit
        btn.tintColor = .label

        if let image = UIImage(named: "bonus") {
            let original = image.withRenderingMode(.alwaysOriginal)
            btn.setImage(original, for: .normal)
            btn.tintColor = nil
        } else {
            btn.setImage(UIImage(systemName: "bonus"), for: .normal)
        }

        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.separator.cgColor
        return btn
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
        CATransaction.setDisableActions(true) // avoid implicit animations on layout

        gradientRingLayer.frame = bonusButton.bounds

        let inset = ringWidth / 2.0
        let roundedRect = bonusButton.bounds.insetBy(dx: inset, dy: inset)
        let path = UIBezierPath(
            roundedRect: roundedRect,
            cornerRadius: bonusButton.layer.cornerRadius - inset
        )
        ringMask.path = path.cgPath
        ringMask.lineWidth = ringWidth
        ringMask.frame = bonusButton.bounds

        CATransaction.commit()
    }

    private func updateRingColors() {
        let looped = ringColors + [ringColors.first ?? .clear]
        gradientRingLayer.colors = looped.map { $0.cgColor }
    }

    private func setupUi() {
        selectionStyle = .none
        contentView.backgroundColor = .systemBackground

        contentView.addSubview(bonusButton)
        contentView.addSubview(bonusLabel)

        NSLayoutConstraint.activate([
            bonusButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            bonusButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bonusButton.widthAnchor.constraint(equalToConstant: 40),
            bonusButton.heightAnchor.constraint(equalToConstant: 40),

            bonusLabel.centerYAnchor.constraint(equalTo: bonusButton.centerYAnchor),
            bonusLabel.leadingAnchor.constraint(equalTo: bonusButton.trailingAnchor, constant: 12),
            bonusLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),

            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: bonusButton.bottomAnchor, constant: 0)
        ])
        gradientRingLayer.type = .conic
        gradientRingLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientRingLayer.endPoint = CGPoint(x: 1, y: 1)
        updateRingColors()

        ringMask.fillColor = UIColor.clear.cgColor
        ringMask.strokeColor = UIColor.black.cgColor
        ringMask.lineWidth = ringWidth

        gradientRingLayer.mask = ringMask

        bonusButton.layer.addSublayer(gradientRingLayer)

        bonusButton.addAction(UIAction(handler: { _ in
            self.onTap?()
        }), for: .touchUpInside)
    }
}
