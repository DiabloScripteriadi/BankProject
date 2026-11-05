//
//  PiggyView.swift
//  BNK
//
//  Created by chasemedkcorto on 30.08.26.
//


import Foundation
import UIKit
import SwiftUI

class PiggyView: UIView {

    private let piggyContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()

    private let piggyLabel: UILabel = {
        let label = UILabel()
        label.text = "ℙ𝕚𝕘𝕘𝕪 𝕊𝕒𝕧𝕚𝕟𝕘𝕤"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return label
    }()

    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular)
        imageView.image = UIImage(systemName: "pigybank.fill", withConfiguration: config)
        return imageView
    }()

    private let amount: UILabel = {
        let label = UILabel()
        label.text = "1200$"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
    }

    private func setupView() {
        backgroundColor = .clear
        addSubview(piggyContainer)

        piggyContainer.addSubview(icon)
        piggyContainer.addSubview(piggyLabel)
        piggyContainer.addSubview(amount)
    }

    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            piggyContainer.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            piggyContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            piggyContainer.widthAnchor.constraint(equalToConstant: 190),
            piggyContainer.heightAnchor.constraint(equalToConstant: 75),
            piggyContainer.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: piggyContainer.topAnchor, constant: 6),
            icon.leadingAnchor.constraint(equalTo: piggyContainer.leadingAnchor, constant: 12),
            icon.widthAnchor.constraint(equalToConstant: 18),
            icon.heightAnchor.constraint(equalToConstant: 24)
        ])

        NSLayoutConstraint.activate([
            piggyLabel.topAnchor.constraint(equalTo: piggyContainer.topAnchor, constant: 9),
            piggyLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8),
            piggyLabel.trailingAnchor.constraint(lessThanOrEqualTo: piggyContainer.trailingAnchor, constant: -12)
        ])

        NSLayoutConstraint.activate([
            amount.topAnchor.constraint(equalTo: piggyLabel.bottomAnchor, constant: 6),
            amount.leadingAnchor.constraint(equalTo: piggyLabel.leadingAnchor,constant: -24),
            amount.trailingAnchor.constraint(lessThanOrEqualTo: piggyContainer.trailingAnchor, constant:
                                            -12),
            amount.bottomAnchor.constraint(lessThanOrEqualTo: piggyContainer.bottomAnchor, constant: -10)
        ])
    }
}

#Preview {
   PiggyView()
}
