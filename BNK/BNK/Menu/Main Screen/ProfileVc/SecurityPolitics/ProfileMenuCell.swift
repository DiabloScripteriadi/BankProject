import UIKit

final class ProfileMenuCell: UITableViewCell {

    static let identifier = "ProfileMenuCell"
    var onTap: (() -> Void)?

    // მრგვალი, ბანკის სტილის აიქონის კონტეინერი
    private let iconButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .secondarySystemBackground
        btn.layer.masksToBounds = true
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.separator.withAlphaComponent(0.5).cgColor
        return btn
    }()

    // მენიუს ტექსტი
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 16, weight: .medium)
        lbl.textColor = .label
        lbl.numberOfLines = 1
        return lbl
    }()
    
    // მარჯვენა ისარი
    private let chevronImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "chevron.right"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.tintColor = .tertiaryLabel
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // აიქონის ფონს აქცევს სრულად მრგვალად
        iconButton.layer.cornerRadius = iconButton.bounds.height / 2
    }

    private func setupUI() {
        selectionStyle = .none
        contentView.backgroundColor = .clear // ვასუფთავებთ, რომ insetGrouped სტილმა ლამაზად გამოკვეთოს ქარდი

        contentView.addSubview(iconButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(chevronImageView)

        NSLayoutConstraint.activate([
            iconButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconButton.widthAnchor.constraint(equalToConstant: 48),
            iconButton.heightAnchor.constraint(equalToConstant: 48),

            titleLabel.leadingAnchor.constraint(equalTo: iconButton.trailingAnchor, constant: 14),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: chevronImageView.leadingAnchor, constant: -12),
            
            chevronImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            chevronImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            chevronImageView.widthAnchor.constraint(equalToConstant: 10),
            chevronImageView.heightAnchor.constraint(equalToConstant: 16)
        ])

        iconButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        contentView.addGestureRecognizer(tap)
    }

    // კონფიგურაციის მეთოდი სათაურის, აიქონისა და ფერის მისანიჭებლად
    func configure(title: String, iconName: String, tintColor: UIColor) {
        titleLabel.text = title
        
        if let image = UIImage(named: iconName) {
            iconButton.setImage(image, for: .normal)
        } else {
            iconButton.setImage(UIImage(systemName: iconName), for: .normal)
        }
        iconButton.tintColor = tintColor
    }

    @objc private func handleTap() {
        onTap?()
    }
}