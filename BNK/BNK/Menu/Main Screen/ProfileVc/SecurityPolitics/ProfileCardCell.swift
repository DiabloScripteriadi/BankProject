import UIKit

// MARK: - Regular card (icon on top, title, value at the bottom)

final class ProfileCardCell: UICollectionViewCell {

    static let reuseID = "ProfileCardCell"

    private let cardView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .secondarySystemBackground
        v.layer.cornerRadius = 28
        v.layer.cornerCurve = .continuous
        v.layer.masksToBounds = true
        return v
    }()

    private let illustrationView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 40, weight: .regular)
        return iv
    }()

    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .systemFont(ofSize: 15, weight: .regular)
        lb.textColor = .secondaryLabel
        lb.numberOfLines = 1
        lb.lineBreakMode = .byTruncatingTail
        return lb
    }()

    private let valueLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .systemFont(ofSize: 24, weight: .semibold)
        lb.textColor = .label
        lb.numberOfLines = 1
        lb.adjustsFontSizeToFitWidth = true
        lb.minimumScaleFactor = 0.7
        return lb
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cardView)
        cardView.addSubview(illustrationView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(valueLabel)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            illustrationView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 18),
            illustrationView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 18),
            illustrationView.widthAnchor.constraint(equalToConstant: 72),
            illustrationView.heightAnchor.constraint(equalToConstant: 72),

            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 18),
            titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -18),
            titleLabel.bottomAnchor.constraint(equalTo: valueLabel.topAnchor, constant: -14),

            valueLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 18),
            valueLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -18),
            valueLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -18)
        ])
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.15) {
                self.cardView.transform = self.isHighlighted
                    ? CGAffineTransform(scaleX: 0.97, y: 0.97)
                    : .identity
            }
        }
    }

    func configure(title: String, value: String?, image: UIImage?, tint: UIColor) {
        titleLabel.text = title
        valueLabel.text = value
        valueLabel.isHidden = (value == nil)
        illustrationView.image = image
        illustrationView.tintColor = tint
    }
}

// MARK: - Full-width logout card

final class ProfileLogoutCell: UICollectionViewCell {

    static let reuseID = "ProfileLogoutCell"

    private let cardView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .secondarySystemBackground
        v.layer.cornerRadius = 24
        v.layer.cornerCurve = .continuous
        v.layer.masksToBounds = true
        return v
    }()

    private let iconView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .systemRed
        iv.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)
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
        cardView.addSubview(iconView)
        cardView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            iconView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            iconView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 28),
            iconView.heightAnchor.constraint(equalToConstant: 28),

            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 14),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: cardView.trailingAnchor, constant: -20),
            titleLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.15) {
                self.cardView.transform = self.isHighlighted
                    ? CGAffineTransform(scaleX: 0.98, y: 0.98)
                    : .identity
            }
        }
    }

    func configure(title: String, image: UIImage?) {
        titleLabel.text = title
        iconView.image = image
    }
}