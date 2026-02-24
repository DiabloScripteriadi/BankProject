//
//  ContactsCell.swift
//  BNK
//
//  Created by chasemedkcorto on 12.02.26.
//

import UIKit
class ContactsCell: UITableViewCell {

    var onTap: (() -> Void)?

    private let contactButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .secondarySystemBackground
        btn.layer.masksToBounds = true
        btn.imageView?.contentMode = .scaleAspectFit
        btn.tintColor = .label
        
        if let image = UIImage(systemName: "person"){
            btn.setImage(image, for: .normal)
        }
       
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.separator.cgColor
        return btn
    }()

    private let contactNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = ""
        lbl.font = .systemFont(ofSize: 14, weight: .medium)
        lbl.textColor = .black
        lbl.numberOfLines = 1
        return lbl
    }()
    private let contactNumberLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = ""
        lbl.font = .systemFont(ofSize: 13, weight: .medium)
        lbl.textColor = .gray
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
        contactButton.layer.cornerRadius =  contactButton.bounds.height / 2
    }

    private func setupUi() {
        selectionStyle = .none
        contentView.backgroundColor = .systemBackground

        contentView.addSubview(contactButton)
        contentView.addSubview(contactNameLabel)
        contentView.addSubview(contactNumberLabel)
        NSLayoutConstraint.activate([
            contactButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            contactButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contactButton.widthAnchor.constraint(equalToConstant: 30),
            contactButton.heightAnchor.constraint(equalToConstant: 30),

//            contactNameLabel.centerYAnchor.constraint(equalTo: contactButton.centerYAnchor),
//            contactNameLabel.leadingAnchor.constraint(equalTo: contactButton.trailingAnchor, constant: 12),
//            contactNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            
            contactNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 65),
            contactNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            contactNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 65),
            contactNumberLabel.topAnchor.constraint(equalTo: contactNameLabel.topAnchor, constant: 20),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: contactButton.bottomAnchor, constant: 0)
        ])
    }
    func configure(name: String, number: String) {
        contactNameLabel.text = name
        contactNumberLabel.text = number
    }
}

