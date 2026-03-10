//
//  AddCard.swift
//  BNK
//
//  Created by chasemedkcorto on 24.02.26.

import UIKit
class Card: UIView {

    private let shadowContainer = UIView()
    private let cardView        = UIView()
    private let gradientLayer   = CAGradientLayer()
    private let chipView        = UIView()
    private let chipGradient    = CAGradientLayer()
    private let minyView        = UIView()

    private let visaLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "𝙑𝙄𝙎𝘼"
        lb.textColor = UIColor.white.withAlphaComponent(0.85)
        lb.font = .italicSystemFont(ofSize: 22)
        return lb
    }()

    private let cardNumberLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "••••  ••••  ••••  ••••"
        lb.font = .monospacedSystemFont(ofSize: 15, weight: .medium)
        lb.textColor = UIColor.white.withAlphaComponent(0.75)
        return lb
    }()

    private let cardHolderMinyLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "CARD HOLDER"
        lb.font = .systemFont(ofSize: 8, weight: .medium)
        lb.textColor = UIColor.white.withAlphaComponent(0.4)
        return lb
    }()

    private let cardHolderLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "FULL NAME"
        lb.font = .systemFont(ofSize: 12, weight: .semibold)
        lb.textColor = UIColor.white.withAlphaComponent(0.85)
        return lb
    }()

    private let expiresMinyLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "EXPIRES"
        lb.font = .systemFont(ofSize: 8, weight: .medium)
        lb.textColor = UIColor.white.withAlphaComponent(0.4)
        return lb
    }()

    private let expireLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "MM / YY"
        lb.font = .systemFont(ofSize: 12, weight: .semibold)
        lb.textColor = UIColor.white.withAlphaComponent(0.85)
        return lb
    }()

    private let mc1 = UIView()
    private let mc2 = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = .clear
        setupShadowContainer()
        setupCard()
        setupGradient()
        setupChip()
        setupMinyView()
        setupLabels()
        setupMastercard()
        add3DTilt()
    }

    private func setupShadowContainer() {
        shadowContainer.translatesAutoresizingMaskIntoConstraints = false
        shadowContainer.backgroundColor = .purple
        shadowContainer.layer.shadowColor  = UIColor(red: 0.18, green: 0.15, blue: 0.38, alpha: 1).cgColor
        shadowContainer.layer.shadowOpacity = 0.45
        shadowContainer.layer.shadowOffset  = CGSize(width: 0, height: 12)
        shadowContainer.layer.shadowRadius  = 24
        shadowContainer.layer.cornerRadius  = 20
        addSubview(shadowContainer)

        NSLayoutConstraint.activate([
            shadowContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            shadowContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            shadowContainer.widthAnchor.constraint(equalToConstant: 300),
            shadowContainer.heightAnchor.constraint(equalToConstant: 180)
        ])
    }

    private func setupCard() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.layer.cornerRadius = 20
        cardView.clipsToBounds = true
        shadowContainer.addSubview(cardView)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: shadowContainer.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: shadowContainer.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: shadowContainer.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: shadowContainer.bottomAnchor)
        ])
    }
    //esec 3d da ait gavakete
    private func setupGradient() {
        gradientLayer.colors = [
            UIColor(red: 0.12, green: 0.10, blue: 0.23, alpha: 1).cgColor,
            UIColor(red: 0.18, green: 0.15, blue: 0.38, alpha: 1).cgColor,
            UIColor(red: 0.23, green: 0.13, blue: 0.50, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint   = CGPoint(x: 1, y: 1)
        cardView.layer.insertSublayer(gradientLayer, at: 0)

        let gloss = CAGradientLayer()
        gloss.name = "gloss"
        gloss.colors = [
            UIColor.white.withAlphaComponent(0.10).cgColor,
            UIColor.white.withAlphaComponent(0.00).cgColor
        ]
        gloss.startPoint = CGPoint(x: 0.5, y: 0)
        gloss.endPoint   = CGPoint(x: 0.5, y: 1)
        cardView.layer.insertSublayer(gloss, at: 1)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = cardView.bounds
        chipGradient.frame  = chipView.bounds

        if let gloss = cardView.layer.sublayers?.first(where: { $0.name == "gloss" }) {
            gloss.frame = CGRect(x: 0, y: 0,
                                 width: cardView.bounds.width,
                                 height: cardView.bounds.height * 0.5)
        }
    }
    //esec ait
    private func setupChip() {
        chipView.translatesAutoresizingMaskIntoConstraints = false
        chipView.layer.cornerRadius = 4
        chipView.clipsToBounds = true

        chipGradient.colors = [
            UIColor(red: 0.78, green: 0.56, blue: 0.04, alpha: 1).cgColor,
            UIColor(red: 0.94, green: 0.82, blue: 0.38, alpha: 1).cgColor
        ]
        chipGradient.startPoint = CGPoint(x: 0, y: 0)
        chipGradient.endPoint   = CGPoint(x: 1, y: 1)
        chipView.layer.addSublayer(chipGradient)
        cardView.addSubview(chipView)

        NSLayoutConstraint.activate([
            chipView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 18),
            chipView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 18),
            chipView.widthAnchor.constraint(equalToConstant: 34),
            chipView.heightAnchor.constraint(equalToConstant: 26)
        ])
    }

    private func setupMinyView() {
        minyView.backgroundColor = UIColor.systemYellow
        minyView.layer.cornerRadius = 12
        minyView.layer.shadowColor = UIColor.black.cgColor
        minyView.layer.shadowOpacity = 0.25
        minyView.layer.shadowOffset = CGSize(width: 0, height: 3)
        minyView.layer.shadowRadius = 5

        cardView.addSubview(minyView)
        minyView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            minyView.widthAnchor.constraint(equalToConstant: 50),
            minyView.heightAnchor.constraint(equalToConstant: 35),
            minyView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            minyView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15)
        ])
    }

    private func setupLabels() {
        [visaLabel, cardNumberLabel,
         cardHolderMinyLabel, cardHolderLabel,
         expiresMinyLabel, expireLabel].forEach {
            cardView.addSubview($0)
        }

        NSLayoutConstraint.activate([
            visaLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 18),
            visaLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -18),

            cardNumberLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor, constant: 4),
            cardNumberLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 18),

            cardHolderMinyLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -36),
            cardHolderMinyLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 18),

            cardHolderLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
            cardHolderLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 18),

            expiresMinyLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -36),
            expiresMinyLabel.leadingAnchor.constraint(equalTo: cardHolderLabel.trailingAnchor, constant: 24),

            expireLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
            expireLabel.leadingAnchor.constraint(equalTo: expiresMinyLabel.leadingAnchor),
        ])
    }

    private func setupMastercard() {
        [mc1, mc2].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.layer.cornerRadius = 11
            cardView.addSubview($0)
        }
        mc1.backgroundColor = UIColor(red: 0.86, green: 0.20, blue: 0.12, alpha: 0.88)
        mc2.backgroundColor = UIColor(red: 0.94, green: 0.55, blue: 0.08, alpha: 0.78)

        NSLayoutConstraint.activate([
            mc1.widthAnchor.constraint(equalToConstant: 22),
            mc1.heightAnchor.constraint(equalToConstant: 22),
            mc1.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
            mc1.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -28),

            mc2.widthAnchor.constraint(equalToConstant: 22),
            mc2.heightAnchor.constraint(equalToConstant: 22),
            mc2.centerYAnchor.constraint(equalTo: mc1.centerYAnchor),
            mc2.leadingAnchor.constraint(equalTo: mc1.leadingAnchor, constant: 13)
        ])
    }

    func updateNumber(_ masked: String) {
        cardNumberLabel.text = masked
    }
    func updateHolder(_ name: String) {
        cardHolderLabel.text = name.isEmpty ? "FULL NAME" : name.uppercased()
    }
    func updateExpiry(_ expiry: String) {
        expireLabel.text = expiry.isEmpty ? "MM / YY" : expiry
    }
    //esec
    private func add3DTilt() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handleTilt(_:)))
        addGestureRecognizer(pan)
    }

    @objc private func handleTilt(_ g: UIPanGestureRecognizer) {
        let t = g.translation(in: self)
        switch g.state {
        case .changed:
            let rx = -(t.y / (bounds.height + 1)) * 22
            let ry =  (t.x / (bounds.width  + 1)) * 22
            var tr = CATransform3DIdentity
            tr.m34 = -1 / 600
            tr = CATransform3DRotate(tr, rx * .pi / 180, 1, 0, 0)
            tr = CATransform3DRotate(tr, ry * .pi / 180, 0, 1, 0)
            shadowContainer.layer.transform = tr
        case .ended, .cancelled:
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 0.65,
                initialSpringVelocity: 0.3
            ) {
                self.shadowContainer.layer.transform = CATransform3DIdentity
            }
        default: break
        }
    }
}


extension UILabel {
var letterSpacing: CGFloat {
    get { 0 }
    set {
        guard let t = text else { return }
        let attr = NSMutableAttributedString(string: t)
        attr.addAttribute(.kern, value: newValue, range: NSRange(location: 0, length: t.count))
        attributedText = attr
    }
}
}
//
//#Preview {
//    UINavigationController(rootViewController: CardVC())
//}
