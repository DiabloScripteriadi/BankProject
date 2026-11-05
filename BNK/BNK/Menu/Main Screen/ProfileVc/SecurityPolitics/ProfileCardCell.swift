//
//  ProfileCardCell.swift
//  BNK
//
//  Created by chasemedkcorto on 03/11/2026.
//


import UIKit

final class ProfileCardCell: UICollectionViewCell {

    static let reuseID = "ProfileCardCell"

    private let cardView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .secondarySystemBackground
        v.layer.cornerRadius = 26
        v.layer.cornerCurve = .continuous
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.separator.withAlphaComponent(0.35).cgColor
        return v
    }()

    private let badgeView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 26
        v.layer.cornerCurve = .continuous
        return v
    }()

    private let iconView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 22, weight: .semibold)
        return iv
    }()

    private let arrowView: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "arrow.up.right"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .tertiaryLabel
        iv.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 13, weight: .bold)
        return iv
    }()

    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 16, weight: .semibold)
        lb.textColor = .label
        lb.numberOfLines = 2
        return lb
    }()

    private let subtitleLabel: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 13, weight: .regular)
        lb.textColor = .secondaryLabel
        lb.numberOfLines = 1
        lb.lineBreakMode = .byTruncatingTail
        return lb
    }()

    private lazy var textStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .vertical
        s.spacing = 3
        return s
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cardView)
        cardView.addSubview(badgeView)
        badgeView.addSubview(iconView)
        cardView.addSubview(arrowView)
        cardView.addSubview(textStack)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            badgeView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 18),
            badgeView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 18),
            badgeView.widthAnchor.constraint(equalToConstant: 52),
            badgeView.heightAnchor.constraint(equalToConstant: 52),

            iconView.centerXAnchor.constraint(equalTo: badgeView.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: badgeView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 26),
            iconView.heightAnchor.constraint(equalToConstant: 26),

            arrowView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            arrowView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -18),
            arrowView.widthAnchor.constraint(equalToConstant: 16),
            arrowView.heightAnchor.constraint(equalToConstant: 16),

            textStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 18),
            textStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -18),
            textStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -18),
            textStack.topAnchor.constraint(greaterThanOrEqualTo: badgeView.bottomAnchor, constant: 10)
        ])
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.25,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0.4,
                           options: [.allowUserInteraction, .beginFromCurrentState]) {
                self.cardView.transform = self.isHighlighted
                    ? CGAffineTransform(scaleX: 0.96, y: 0.96)
                    : .identity
            }
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        cardView.layer.borderColor = UIColor.separator.withAlphaComponent(0.35).cgColor
    }

    func configure(title: String, subtitle: String, image: UIImage?, tint: UIColor) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        iconView.image = image
        iconView.tintColor = tint
        badgeView.backgroundColor = tint.withAlphaComponent(0.14)
    }
}

final class ProfileLogoutCell: UICollectionViewCell {

    static let reuseID = "ProfileLogoutCell"

    private let cardView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.systemRed.withAlphaComponent(0.10)
        v.layer.cornerRadius = 24
        v.layer.cornerCurve = .continuous
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.systemRed.withAlphaComponent(0.22).cgColor
        return v
    }()

    private let badgeView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.systemRed.withAlphaComponent(0.16)
        v.layer.cornerRadius = 22
        v.layer.cornerCurve = .continuous
        return v
    }()

    private let iconView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .systemRed
        iv.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)
        return iv
    }()

    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .systemFont(ofSize: 17, weight: .semibold)
        lb.textColor = .systemRed
        return lb
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cardView)
        cardView.addSubview(badgeView)
        badgeView.addSubview(iconView)
        cardView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            badgeView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 14),
            badgeView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            badgeView.widthAnchor.constraint(equalToConstant: 44),
            badgeView.heightAnchor.constraint(equalToConstant: 44),

            iconView.centerXAnchor.constraint(equalTo: badgeView.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: badgeView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 22),
            iconView.heightAnchor.constraint(equalToConstant: 22),

            titleLabel.leadingAnchor.constraint(equalTo: badgeView.trailingAnchor, constant: 14),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: cardView.trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.25,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0.4,
                           options: [.allowUserInteraction, .beginFromCurrentState]) {
                self.cardView.transform = self.isHighlighted
                    ? CGAffineTransform(scaleX: 0.97, y: 0.97)
                    : .identity
            }
        }
    }

    func configure(title: String, image: UIImage?) {
        titleLabel.text = title
        iconView.image = image
    }
}
