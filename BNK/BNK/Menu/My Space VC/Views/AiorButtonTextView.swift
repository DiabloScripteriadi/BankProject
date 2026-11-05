//
//  File.swift
//  BNK
//
//  Created by chasemedkcorto on 28.08.26.
//

import Foundation
import UIKit

class AiorButtonTextView: UIView {

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

    private let label: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "𝕀𝕗 𝕐𝕠𝕦 𝕎𝕠𝕦𝕝𝕕 𝕃𝕚𝕜𝕖 𝕋𝕠 ℂ𝕙𝕒𝕥 𝕎𝕚𝕥𝕙 𝔸𝕚 𝕋𝕒𝕡 𝕒 𝔸𝕚 𝔹𝕦𝕥𝕥𝕠𝕟"
        lb.font = .boldSystemFont(ofSize: 18)
        lb.textColor = .white
        lb.numberOfLines = 0
        lb.textAlignment = .center
        return lb
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()

    private let gradientRingLayer = CAGradientLayer()
    private let ringMask = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = .systemBackground

        addSubview(containerView)
        containerView.addSubview(label)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 70),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),

            label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])

        gradientRingLayer.type = .conic
        gradientRingLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientRingLayer.endPoint = CGPoint(x: 1, y: 1)
        updateRingColors()

        ringMask.fillColor = UIColor.clear.cgColor
        ringMask.strokeColor = UIColor.black.cgColor
        ringMask.lineWidth = ringWidth

        gradientRingLayer.mask = ringMask

        containerView.layer.addSublayer(gradientRingLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        CATransaction.begin()
        CATransaction.setDisableActions(true) // avoid implicit animations on layout

        gradientRingLayer.frame = containerView.bounds

        let inset = ringWidth / 2.0
        let roundedRect = containerView.bounds.insetBy(dx: inset, dy: inset)
        let path = UIBezierPath(roundedRect: roundedRect, cornerRadius: containerView.layer.cornerRadius - inset)
        ringMask.path = path.cgPath
        ringMask.lineWidth = ringWidth
        ringMask.frame = containerView.bounds

        CATransaction.commit()
    }

    private func updateRingColors() {
        let looped = ringColors + [ringColors.first ?? .clear]
        gradientRingLayer.colors = looped.map { $0.cgColor }
    }
    }
//
//#Preview {
//    let view = AiorButtonText()
//    view.frame = CGRect(x: 0, y: 0, width: 320, height: 120)
//    return view
//}
