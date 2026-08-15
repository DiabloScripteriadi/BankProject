
private final class FuturisticInfoCard: UIView {
    // Visual elements
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
    private let container = UIView()
    private let symbolView = UIImageView()
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()

    // Effects
    private let gradientBorder = CAGradientLayer()
    private let borderMask = CAShapeLayer()
    private let innerGlow = CAGradientLayer()
    private let sparkline = CAShapeLayer()

    // Parameters
    private let corner: CGFloat = 16
    private var accentColor: UIColor = .systemTeal

    init(title: String,
         value: String,
         symbolName: String,
         gradientColors: [UIColor],
         accentColors: [UIColor]) {
        super.init(frame: .zero)
        isUserInteractionEnabled = true
        layer.cornerRadius = corner
        layer.cornerCurve = .continuous
        clipsToBounds = false

        self.accentColor = accentColors.first ?? .systemTeal

        setupShadow()
        setupBlur()
        setupContainer()
        setupSymbol(symbolName: symbolName)
        setupLabels(title: title, value: value)
        setupGradientBorder(colors: gradientColors)
        setupInnerGlow()
        setupSparkline()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func layoutSubviews() {
        super.layoutSubviews()
        blurView.frame = bounds
        container.frame = bounds

        let rounded = UIBezierPath(roundedRect: bounds.insetBy(dx: 0.5, dy: 0.5), cornerRadius: corner).cgPath

        gradientBorder.frame = bounds
        borderMask.path = rounded
        gradientBorder.mask = borderMask

        innerGlow.frame = CGRect(x: 0, y: bounds.height * 0.58, width: bounds.width, height: bounds.height * 0.42)
        innerGlow.cornerRadius = corner

        updateSparklinePath()
    }

    // MARK: - Setup

    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.12
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowRadius = 14
    }

    private func setupBlur() {
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.layer.cornerRadius = corner
        blurView.layer.masksToBounds = true
        addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func setupContainer() {
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor.secondarySystemBackground.withAlphaComponent(0.16)
        container.layer.cornerRadius = corner
        container.layer.cornerCurve = .continuous
        container.layer.borderColor = UIColor.white.withAlphaComponent(0.06).cgColor
        container.layer.borderWidth = 1
        addSubview(container)

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func setupSymbol(symbolName: String) {
        symbolView.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 26, weight: .semibold)
        let image = UIImage(systemName: symbolName, withConfiguration: config)
        symbolView.image = image
        symbolView.tintColor = accentColor
        symbolView.contentMode = .scaleAspectFit

        // Soft static glow
        symbolView.layer.shadowColor = accentColor.withAlphaComponent(0.8).cgColor
        symbolView.layer.shadowRadius = 8
        symbolView.layer.shadowOpacity = 0.6
        symbolView.layer.shadowOffset = .zero

        container.addSubview(symbolView)

        NSLayoutConstraint.activate([
            symbolView.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            symbolView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            symbolView.widthAnchor.constraint(equalToConstant: 28),
            symbolView.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

    private func setupLabels(title: String, value: String) {
        [titleLabel, valueLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview($0)
        }

        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 13, weight: .medium)
        titleLabel.textColor = .secondaryLabel

        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 22, weight: .bold)
        valueLabel.textColor = .label

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: symbolView.bottomAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: symbolView.leadingAnchor),

            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            valueLabel.bottomAnchor.constraint(lessThanOrEqualTo: container.bottomAnchor, constant: -18)
        ])
    }

    private func setupGradientBorder(colors: [UIColor]) {
        gradientBorder.type = .axial
        gradientBorder.startPoint = CGPoint(x: 0, y: 0)
        gradientBorder.endPoint = CGPoint(x: 1, y: 1)
        gradientBorder.colors = colors.map { $0.withAlphaComponent(0.9).cgColor }

        borderMask.lineWidth = 2
        borderMask.fillColor = UIColor.clear.cgColor
        borderMask.strokeColor = UIColor.white.cgColor

        layer.addSublayer(gradientBorder)
        gradientBorder.mask = borderMask
    }

    private func setupInnerGlow() {
        innerGlow.colors = [
            accentColor.withAlphaComponent(0.10).cgColor,
            UIColor.clear.cgColor
        ]
        innerGlow.startPoint = CGPoint(x: 0.5, y: 0)
        innerGlow.endPoint   = CGPoint(x: 0.5, y: 1)
        layer.addSublayer(innerGlow)
    }

    private func setupSparkline() {
        sparkline.strokeColor = accentColor.withAlphaComponent(0.8).cgColor
        sparkline.fillColor = UIColor.clear.cgColor
        sparkline.lineWidth = 1.2
        sparkline.lineJoin = .round
        sparkline.lineCap = .round
        layer.addSublayer(sparkline)
    }

    private func updateSparklinePath() {
        let inset: CGFloat = 12
        let w = bounds.width - inset * 2
        let h: CGFloat = 22
        let y = bounds.height - h - 12

        guard w > 0 else { return }

        let path = UIBezierPath()
        let points = 10
        for i in 0..<points {
            let x = CGFloat(i) / CGFloat(points - 1) * w + inset
            let t = CGFloat(i)
            let value = y + h/2 + sin(t * 0.7) * 4
            if i == 0 {
                path.move(to: CGPoint(x: x, y: value))
            } else {
                path.addLine(to: CGPoint(x: x, y: value))
            }
        }
        sparkline.path = path.cgPath
    }
}
