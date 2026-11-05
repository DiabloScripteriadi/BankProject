//
//  SettingsCell.swift
//  BNK
//
//  Created by chasemedkcorto on 06.02.26.
//
import UIKit

final class NottificationsCell: UITableViewCell {

    var onTap: (() -> Void)?

    private let notficationsButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .secondarySystemBackground
        btn.layer.masksToBounds = true
        btn.imageView?.contentMode = .scaleAspectFit
        btn.tintColor = .label
        
        if let image = UIImage(named: "notification") {
            btn.setImage(image, for: .normal)
        } else {
            btn.setImage(UIImage(systemName: "bell.badge"), for: .normal)
        }
       
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.separator.withAlphaComponent(0.5).cgColor
        return btn
    }()

    private let notficationsLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Notifications"
        lbl.font = .systemFont(ofSize: 16, weight: .medium)
        lbl.textColor = .label
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private let chevronImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "chevron.right"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.tintColor = .tertiaryLabel
        iv.contentMode = .scaleAspectFit
        return iv
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
        notficationsButton.layer.cornerRadius = notficationsButton.bounds.height / 2
    }

    private func setupUi() {
        selectionStyle = .none
        contentView.backgroundColor = .clear // ვასუფთავებთ, რომ სექციის მთავარ ქარდს ერწყმოდეს

        contentView.addSubview(notficationsButton)
        contentView.addSubview(notficationsLabel)
        contentView.addSubview(chevronImageView)

        NSLayoutConstraint.activate([
            notficationsButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            notficationsButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            notficationsButton.widthAnchor.constraint(equalToConstant: 48),
            notficationsButton.heightAnchor.constraint(equalToConstant: 48),

            notficationsLabel.leadingAnchor.constraint(equalTo: notficationsButton.trailingAnchor, constant: 14),
            notficationsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            notficationsLabel.trailingAnchor.constraint(lessThanOrEqualTo: chevronImageView.leadingAnchor, constant: -12),
            
            chevronImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            chevronImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            chevronImageView.widthAnchor.constraint(equalToConstant: 10),
            chevronImageView.heightAnchor.constraint(equalToConstant: 16),
            
            contentView.heightAnchor.constraint(equalToConstant: 72)
        ])

        notficationsButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        contentView.addGestureRecognizer(tap)
    }

    @objc private func handleTap() {
        onTap?()
    }
}
