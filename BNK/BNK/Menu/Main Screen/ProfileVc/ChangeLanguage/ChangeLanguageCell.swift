//
//  SettingsCell.swift
//  BNK
//
//  Created by chasemedkcorto on 06.02.26.
//

import UIKit
import FirebaseAuth

class ChangeLanguageCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUi()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private let changeLanguageLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Claim Money"
        lbl.font = .systemFont(ofSize: 14, weight: .medium)
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        return lbl
    }()

    private let changeLanguageButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .secondarySystemBackground
        btn.layer.cornerRadius = 20
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.darkGray.cgColor
        btn.clipsToBounds = true
        return btn
    }()


    private func setupUi() {
        contentView.addSubview(changeLanguageButton)
        contentView.addSubview(changeLanguageLabel)
        
        NSLayoutConstraint.activate([
            changeLanguageButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            changeLanguageButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),])
    }
    
}
