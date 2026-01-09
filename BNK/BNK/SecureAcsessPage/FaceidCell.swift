//
//  SecureVCCEll.swift
//  BNK
//
//  Created by chasemedkcorto on 09.01.26.
//

import UIKit
class FaceidCell: UITableViewCell {
 private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        label.textAlignment = .center
        label.text = "Face ID & Passcode"
        return label
 }()
   private let button: UIButton = {
       let button = UIButton()
       button.setTitleColor(.white, for: .normal)
       button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .regular)
       return button
   }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       setupLabels()
       setupButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupButtons() {
        let config = UIImage.SymbolConfiguration(
            pointSize: 30,
            weight: .regular
        )

        let image = UIImage(systemName: "faceid", withConfiguration: config)

        button.setImage(image, for: .normal)
        button.tintColor = .black

        button.imageView?.contentMode = .scaleAspectFit

        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 50),
            button.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    private func setupLabels() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 60),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
}
