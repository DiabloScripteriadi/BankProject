//
//  OffersVc.swift
//  BNK
//
//  Created by chasemedkcorto on 10.08.26.
//

import UIKit
import SwiftUI

class OffersVc: UIViewController, UISearchBarDelegate {
    private let headerSpacing : CGFloat = 12
    private let cardSize = CGSize(width: 280, height:200)
    let cardManager = CardManager()
    private let offersBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Offers", for: .normal)
        btn.setImage(UIImage(systemName: "gift.fill"), for: .normal)
        btn.tintColor = .label
        btn.setTitleColor(.label, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .secondarySystemBackground
        btn.layer.cornerRadius = 18
        btn.clipsToBounds = true
        btn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 4)
        btn.titleLabel?.lineBreakMode = .byTruncatingTail
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.separator.cgColor
        btn.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 16, weight: .medium), forImageIn: .normal)
        return btn
    }()
    
    private let promocodeBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Promo codes", for: .normal)
        btn.setImage(UIImage(systemName: "tag.fill"), for: .normal)
        btn.tintColor = .label
        btn.setTitleColor(.label, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .secondarySystemBackground
        btn.layer.cornerRadius = 18
        btn.clipsToBounds = true
        btn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 4)
        btn.titleLabel?.lineBreakMode = .byTruncatingTail
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.separator.cgColor
        btn.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 16, weight: .medium), forImageIn: .normal)
        return btn
    }()
    
    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.searchBarStyle = .minimal
        bar.placeholder = "Search offers"
        bar.autocapitalizationType = .none
        bar.autocorrectionType = .no
        return bar
    }()
    
    private let offersLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Offers"
        lbl.font = UIFont.boldSystemFont(ofSize: 28)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var cardsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 24, right: 20)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CardsCells.self, forCellWithReuseIdentifier: "CardsCells")
        cv.dataSource = self
        cv.delegate = self
        cv.showsVerticalScrollIndicator = true
        cv.delaysContentTouches = false
        return cv
    }()
    
    private var offers: [Offer] = []
    private var filteredOffers: [Offer] = []
    private var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupLabels()
        setupSearchBar()
        setupSorting()
        setupActions()
        setupCollectionView()
        
        cardManager.getCardCellData { [weak self] loadedOffers in
            DispatchQueue.main.async {
                self?.offers = loadedOffers
                self?.filteredOffers = loadedOffers
                 
                self?.cardsCollectionView.reloadData()
            }
        }
    }
    
    private func setupLabels() {
        view.addSubview(offersLabel)
        NSLayoutConstraint.activate([
            offersLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            offersLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        ])
    }
    
    private func setupSearchBar() {
        view.addSubview(searchBar)
        searchBar.delegate = self
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: offersLabel.bottomAnchor, constant: 12),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchBar.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupSorting() {
        view.addSubview(offersBtn)
        view.addSubview(promocodeBtn)
        
        promocodeBtn.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            offersBtn.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            offersBtn.leadingAnchor.constraint(equalTo: offersLabel.leadingAnchor),
            offersBtn.heightAnchor.constraint(equalToConstant: 36),
            
            promocodeBtn.centerYAnchor.constraint(equalTo: offersBtn.centerYAnchor),
            promocodeBtn.leadingAnchor.constraint(equalTo: offersBtn.trailingAnchor, constant: 12),
            promocodeBtn.heightAnchor.constraint(equalTo: offersBtn.heightAnchor),
            promocodeBtn.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupActions() {
        let offersAction = UIAction { [weak self] _ in
            self?.sortOffersByTitle()
        }
        offersBtn.addAction(offersAction, for: .touchUpInside)
        
        let promoAction = UIAction { [weak self] _ in
            self?.sortOffersByPromoCode()
        }
        promocodeBtn.addAction(promoAction, for: .touchUpInside)
    }
    
    private func setupCollectionView() {
        view.addSubview(cardsCollectionView)
        NSLayoutConstraint.activate([
            cardsCollectionView.topAnchor.constraint(equalTo: offersBtn.bottomAnchor, constant: headerSpacing),
            cardsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cardsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

    }
    
    var offerTitle: [Offer] = []
    var promocodeTitle: [Offer] = []
    
    private func sortOffersByTitle() {
        if isSearching {
            filteredOffers.sort { $0.offerTitle.localizedCaseInsensitiveCompare($1.offerTitle) == .orderedAscending }
        } else {
            offers.sort { $0.offerTitle.localizedCaseInsensitiveCompare($1.offerTitle) == .orderedAscending }
        }
        cardsCollectionView.reloadData()
    }
    
    private func sortOffersByPromoCode() {
        if isSearching {
            filteredOffers.sort { $0.promoCode.localizedCaseInsensitiveCompare($1.promoCode) == .orderedAscending }
        } else {
            offers.sort { $0.promoCode.localizedCaseInsensitiveCompare($1.promoCode) == .orderedAscending }
        }
        cardsCollectionView.reloadData()
    }
}

extension OffersVc: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearching ? filteredOffers.count : offers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardsCells", for: indexPath) as? CardsCells else {
            return UICollectionViewCell()
        }
        let data = isSearching ? filteredOffers : offers
        let offer = data[indexPath.item]
        cell.configure(with: offer)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flow = collectionViewLayout as? UICollectionViewFlowLayout else {
            return cardSize
        }
        let horizontalInsets = flow.sectionInset.left + flow.sectionInset.right
        let width = collectionView.bounds.width - horizontalInsets
        return CGSize(width: width, height: cardSize.height)
    }
    }
 
extension OffersVc {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if query.isEmpty {
            isSearching = false
            filteredOffers = offers
        } else {
            isSearching = true
            let lower = query.lowercased()
            filteredOffers = offers.filter {
                $0.brand.lowercased().contains(lower)
                || $0.offerTitle.lowercased().contains(lower)
                || $0.promoCode.lowercased().contains(lower)
                || $0.category.lowercased().contains(lower)
            }
        }
        cardsCollectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

//#Preview {
//    OffersVc()
//}
