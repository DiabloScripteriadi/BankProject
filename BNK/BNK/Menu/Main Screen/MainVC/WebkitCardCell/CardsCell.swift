//  CardsCell.swift
//  BNK
//
//  Created by chasemedkcorto on 02.02.26.

import UIKit
import WebKit

import UIKit

final class CardsCell: UICollectionViewCell {

    static let reuseID = "CardsCell"

    private static let imageCache = NSCache<NSURL, UIImage>()

    private static let expiryParser: DateFormatter = {
        let f = DateFormatter()
        f.calendar = Calendar(identifier: .gregorian)
        f.locale = Locale(identifier: "en_US_POSIX")
        f.dateFormat = "yyyy-MM-dd"
        return f
    }()

    private static let displayFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale.current
        f.setLocalizedDateFormatFromTemplate("MMMd")
        return f
    }()

    private var currentOffer: Offer?
    private var currentImageURL: URL?
    private var imageTask: URLSessionDataTask?
    private var resetCopyWork: DispatchWorkItem?

    private let imageViewPoster: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let gradientLayer: CAGradientLayer = {
        let g = CAGradientLayer()
        g.colors = [
            UIColor.black.withAlphaComponent(0).cgColor,
            UIColor.black.withAlphaComponent(0.3).cgColor,
            UIColor.black.withAlphaComponent(0.82).cgColor
        ]
        g.locations = [0.0, 0.45, 1.0]
        return g
    }()

    private let expiryPill: PaddedLabel = {
        let lbl = PaddedLabel(insets: UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10))
        lbl.font = UIFontMetrics(forTextStyle: .caption1).scaledFont(for: .systemFont(ofSize: 12, weight: .bold))
        lbl.adjustsFontForContentSizeCategory = true
        lbl.textColor = UIColor(red: 0.63, green: 0.16, blue: 0.10, alpha: 1)
        lbl.backgroundColor = .white
        lbl.layer.cornerRadius = 12
        lbl.layer.cornerCurve = .continuous
        lbl.clipsToBounds = true
        lbl.isHidden = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private let dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFontMetrics(forTextStyle: .caption1).scaledFont(for: .systemFont(ofSize: 12, weight: .semibold))
        lbl.adjustsFontForContentSizeCategory = true
        lbl.textColor = UIColor.white.withAlphaComponent(0.9)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    let labelTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: .systemFont(ofSize: 15, weight: .bold))
        lbl.adjustsFontForContentSizeCategory = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.8
        lbl.textColor = .white
        return lbl
    }()

    let offerTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFontMetrics(forTextStyle: .footnote).scaledFont(for: .systemFont(ofSize: 13, weight: .bold))
        lbl.adjustsFontForContentSizeCategory = true
        lbl.textColor = .white
        return lbl
    }()

    private let copyButton: HitSlopButton = {
        let b = HitSlopButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()

    private lazy var textStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [labelTitle, offerTitleLabel, copyButton])
        s.axis = .vertical
        s.alignment = .leading
        s.spacing = 2
        s.setCustomSpacing(8, after: offerTitleLabel)
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = contentView.bounds
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageTask?.cancel()
        imageTask = nil
        currentImageURL = nil
        resetCopyWork?.cancel()
        imageViewPoster.image = nil
        labelTitle.text = nil
        offerTitleLabel.text = nil
        expiryPill.isHidden = true
        dateLabel.text = nil
        applyCopyButton(title: "", copied: false)
    }


    private func setupViews() {
        contentView.backgroundColor = .tertiarySystemFill
        contentView.layer.cornerRadius = 20
        contentView.layer.cornerCurve = .continuous
        contentView.clipsToBounds = true

        contentView.addSubview(imageViewPoster)
        contentView.layer.addSublayer(gradientLayer)
        contentView.addSubview(expiryPill)
        contentView.addSubview(textStack)
        contentView.addSubview(dateLabel)

        NSLayoutConstraint.activate([
            imageViewPoster.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageViewPoster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageViewPoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageViewPoster.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            expiryPill.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            expiryPill.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),

            textStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            textStack.trailingAnchor.constraint(lessThanOrEqualTo: dateLabel.leadingAnchor, constant: -8),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            dateLabel.centerYAnchor.constraint(equalTo: copyButton.centerYAnchor),
            textStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])

        copyButton.addAction(UIAction { [weak self] _ in self?.copyPromoCode() }, for: .touchUpInside)
        applyCopyButton(title: "", copied: false)
    }
    func configure(with offer: Offer) {
        currentOffer = offer

        labelTitle.text = offer.brand
        offerTitleLabel.text = offer.offerTitle
        applyCopyButton(title: offer.promoCode, copied: false)
        updateExpiry(offer.expiry)

        copyButton.accessibilityLabel = "Copy promo code \(offer.promoCode)"
        labelTitle.accessibilityLabel = offer.brand

        if let url = URL(string: offer.imageURL) {
            showPoster(from: url)
        }
    }

    private func updateExpiry(_ expiry: String) {
        guard let date = Self.expiryParser.date(from: expiry) else {
            expiryPill.isHidden = true
            dateLabel.text = nil
            return
        }
        dateLabel.text = "Until \(Self.displayFormatter.string(from: date))"
        let cal = Calendar.current
        let days = cal.dateComponents([.day], from: cal.startOfDay(for: Date()), to: cal.startOfDay(for: date)).day ?? 99

        switch days {
        case ..<0:
            expiryPill.text = "Expired"
            expiryPill.isHidden = false
        case 0:
            expiryPill.text = "Expires today"
            expiryPill.isHidden = false
        case 1...3:
            expiryPill.text = days == 1 ? "1 day left" : "\(days) days left"
            expiryPill.isHidden = false
        default:
            expiryPill.isHidden = true
        }
        contentView.accessibilityHint = "Expires \(expiry)"
    }
    func showPoster(from url: URL) {
        currentImageURL = url

        if let cached = Self.imageCache.object(forKey: url as NSURL) {
            imageViewPoster.image = cached
            return
        }

        imageTask?.cancel()
        imageTask = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data, let image = UIImage(data: data) else { return }
            Self.imageCache.setObject(image, forKey: url as NSURL)
            DispatchQueue.main.async {
                // Ignore late responses if the cell was reused for another offer.
                guard let self, self.currentImageURL == url else { return }
                UIView.transition(with: self.imageViewPoster, duration: 0.2, options: .transitionCrossDissolve) {
                    self.imageViewPoster.image = image
                }
            }
        }
        imageTask?.resume()
    }

    // MARK: - Copy code

    private func copyPromoCode() {
        guard let code = currentOffer?.promoCode, !code.isEmpty else { return }

        UIPasteboard.general.string = code
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        applyCopyButton(title: "Copied", copied: true)
        UIAccessibility.post(notification: .announcement, argument: "Promo code copied")

        resetCopyWork?.cancel()
        let work = DispatchWorkItem { [weak self] in
            guard let self, let code = self.currentOffer?.promoCode else { return }
            self.applyCopyButton(title: code, copied: false)
        }
        resetCopyWork = work
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: work)
    }

    private func applyCopyButton(title: String, copied: Bool) {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.baseBackgroundColor = UIColor.white.withAlphaComponent(0.22)
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: copied ? "checkmark" : "doc.on.doc")
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 11, weight: .bold)
        config.imagePlacement = .trailing
        config.imagePadding = 6
        config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10)
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attrs in
            var a = attrs
            a.font = UIFontMetrics(forTextStyle: .caption1).scaledFont(for: .systemFont(ofSize: 12, weight: .bold))
            return a
        }
        copyButton.configuration = config
        copyButton.isHidden = title.isEmpty
    }
}

/// Label with inner padding, used for the "2 days left" pill.
private final class PaddedLabel: UILabel {
    private let insets: UIEdgeInsets

    init(insets: UIEdgeInsets) {
        self.insets = insets
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let s = super.intrinsicContentSize
        return CGSize(width: s.width + insets.left + insets.right,
                      height: s.height + insets.top + insets.bottom)
    }
}

/// Button whose tappable area is at least 44pt tall, even if it looks smaller.
private final class HitSlopButton: UIButton {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let dy = min(0, (bounds.height - 44) / 2)
        return bounds.insetBy(dx: -8, dy: dy).contains(point)
    }
}
