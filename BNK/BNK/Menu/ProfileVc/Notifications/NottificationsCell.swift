//
//  SettingsCell.swift
//  BNK
//
//  Created by chasemedkcorto on 06.02.26.
//
import UIKit
class NottificationsCell: UITableViewCell {

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
            
            btn.setImage(UIImage(systemName: "globe"), for: .normal)
        }
       
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.separator.cgColor
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUi()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        notficationsButton.layer.cornerRadius =  notficationsButton.bounds.height / 2
    }

    private func setupUi() {
        selectionStyle = .none
        contentView.backgroundColor = .systemBackground

        contentView.addSubview(notficationsButton)
        contentView.addSubview(notficationsLabel)

        NSLayoutConstraint.activate([
            notficationsButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            notficationsButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            notficationsButton.widthAnchor.constraint(equalToConstant: 60),
            notficationsButton.heightAnchor.constraint(equalToConstant: 60),

            notficationsLabel.centerYAnchor.constraint(equalTo: notficationsButton.centerYAnchor),
            notficationsLabel.leadingAnchor.constraint(equalTo: notficationsButton.trailingAnchor, constant: 12),
            notficationsLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),

            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: notficationsButton.bottomAnchor, constant: 0)
        ])

       
        notficationsButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        contentView.addGestureRecognizer(tap)
    }

    @objc private func handleTap() {
        onTap?()
    }
}
