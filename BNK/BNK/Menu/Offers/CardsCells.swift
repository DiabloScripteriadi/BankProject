//
//  CardsCell.swift
//  BNK
//
//  Created by chasemedkcorto on 11.08.26.
//



import UIKit
import WebKit

class CardsCells: UICollectionViewCell {
    
    private var currentOffer: Offer?
    
    private let imageViewPoster: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 15
        iv.backgroundColor = .lightGray
        iv.contentMode = .scaleAspectFill
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.orange.cgColor
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let textBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 11, weight: .bold)
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let offerTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 10, weight: .black)
        lbl.textColor = .systemOrange
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let promocodeTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 9, weight: .medium)
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let expiryTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Expiring:"
        lbl.font = .systemFont(ofSize: 8, weight: .regular)
        lbl.textColor = UIColor.white.withAlphaComponent(0.8)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageViewPoster.image = nil
        labelTitle.text = nil
        offerTitleLabel.text = nil
        promocodeTitle.text = nil
        expiryTitle.text = nil
    }

    private func setupImageView() {
        contentView.addSubview(imageViewPoster)
        
        imageViewPoster.addSubview(textBackgroundView)
        
        textBackgroundView.addSubview(labelTitle)
        textBackgroundView.addSubview(offerTitleLabel)
        textBackgroundView.addSubview(promocodeTitle)
        textBackgroundView.addSubview(expiryTitle)

        NSLayoutConstraint.activate([
            imageViewPoster.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageViewPoster.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageViewPoster.widthAnchor.constraint(equalToConstant: 360),
            imageViewPoster.heightAnchor.constraint(equalToConstant: 205),
            
            textBackgroundView.bottomAnchor.constraint(equalTo: imageViewPoster.bottomAnchor),
            textBackgroundView.leadingAnchor.constraint(equalTo: imageViewPoster.leadingAnchor),
            textBackgroundView.trailingAnchor.constraint(equalTo: imageViewPoster.trailingAnchor),
            textBackgroundView.topAnchor.constraint(equalTo: labelTitle.topAnchor, constant: -4),
            
            labelTitle.leadingAnchor.constraint(equalTo: textBackgroundView.leadingAnchor, constant: 6),
            labelTitle.trailingAnchor.constraint(equalTo: textBackgroundView.trailingAnchor, constant: -6),
            
            offerTitleLabel.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 1),
            offerTitleLabel.leadingAnchor.constraint(equalTo: labelTitle.leadingAnchor),
            offerTitleLabel.trailingAnchor.constraint(equalTo: labelTitle.trailingAnchor),
            
            promocodeTitle.topAnchor.constraint(equalTo: offerTitleLabel.bottomAnchor, constant: 1),
            promocodeTitle.leadingAnchor.constraint(equalTo: labelTitle.leadingAnchor),
            promocodeTitle.trailingAnchor.constraint(equalTo: labelTitle.trailingAnchor),
            
            expiryTitle.topAnchor.constraint(equalTo: promocodeTitle.bottomAnchor, constant: 1),
            expiryTitle.leadingAnchor.constraint(equalTo: labelTitle.leadingAnchor),
            expiryTitle.trailingAnchor.constraint(equalTo: labelTitle.trailingAnchor),
            expiryTitle.bottomAnchor.constraint(equalTo: textBackgroundView.bottomAnchor, constant: -4)
        ])
    }
    
    func showPoster(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.imageViewPoster.image = image
            }
            
        }.resume()
    }
    
    func configure(with offer: Offer) {
        self.currentOffer = offer
        
        labelTitle.text = offer.brand
        offerTitleLabel.text = offer.offerTitle
        promocodeTitle.text = offer.promoCode
        expiryTitle.text = offer.expiry
        
        if let url = URL(string: offer.imageURL) {
            showPoster(from: url)
        }
    }
}
