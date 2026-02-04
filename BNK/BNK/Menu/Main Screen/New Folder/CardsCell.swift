//
//  CardsCell.swift
//  BNK
//
//  Created by chasemedkcorto on 02.02.26.
//

import UIKit
import WebKit

class CardsCell: UICollectionViewCell {
    private let imageViewPoster: UIImageView = .init()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupImageView() {
        imageViewPoster.clipsToBounds = true
        imageViewPoster.layer.cornerRadius = 15
        imageViewPoster.backgroundColor = .lightGray
        imageViewPoster.contentMode = .scaleAspectFill
        imageViewPoster.layer.borderWidth = 1
        imageViewPoster.layer.borderColor = UIColor.orange.cgColor
        contentView.addSubview(imageViewPoster)
        imageViewPoster.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageViewPoster.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            imageViewPoster.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageViewPoster.widthAnchor.constraint(equalToConstant: 110),
            imageViewPoster.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}
