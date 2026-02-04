//
//  MainVC.swift
//  BNK
//
//  Created by chasemedkcorto on 30.01.26.
//
import UIKit
import FirebaseAuth

class MainVC: UIViewController {
    
    private let scrollView : UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .systemBackground
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.isScrollEnabled = true
        sv.showsVerticalScrollIndicator = true
        return sv
    }()
    
    private let profileBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("User", for: .normal)
        btn.setImage(UIImage(systemName: "person.circle"), for: .normal)
        btn.tintColor = .label
        btn.setTitleColor(.label, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        btn.backgroundColor = .secondarySystemBackground
        btn.layer.cornerRadius = 20
        btn.clipsToBounds = true
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 4)
        btn.titleLabel?.lineBreakMode = .byTruncatingMiddle
        return btn
    }()
    
    private let balanceTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Balance"
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        lbl.textColor = .secondaryLabel
        return lbl
    }()
    
    private let balanceLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "$0.00 $"
        lbl.font = .systemFont(ofSize: 28, weight: .bold)
        lbl.textColor = .label
        return lbl
    }()
    
    private let mobileButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "iphone"), for: .normal)
        btn.tintColor = .label
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .secondarySystemBackground
        btn.layer.cornerRadius = 16
        btn.clipsToBounds = true
        return btn
    }()
    
    private let mobileTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Deposit To Telephone"
        lbl.font = .systemFont(ofSize: 14, weight: .medium)
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let transferMoneyButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "person.2.fill"), for: .normal)
        btn.tintColor = .label
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .secondarySystemBackground
        btn.layer.cornerRadius = 16
        btn.clipsToBounds = true
        return btn
    }()
    private let transferMoneyTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Transfer Money"
        lbl.font = .systemFont(ofSize: 14, weight: .medium)
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let claimMoneyButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "globe"), for: .normal)
        btn.tintColor = .label
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .secondarySystemBackground
        btn.layer.cornerRadius = 16
        btn.clipsToBounds = true
        return btn
    }()
    private let claimMoneyTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Claim Money"
        lbl.font = .systemFont(ofSize: 14, weight: .medium)
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let myCardButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "creditcard.fill"), for: .normal)
        btn.tintColor = .label
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .secondarySystemBackground
        btn.layer.cornerRadius = 16
        btn.clipsToBounds = true
        return btn
    }()
    private let myCardTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "My Card"
        lbl.font = .systemFont(ofSize: 14, weight: .medium)
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        return lbl
    }()
    private lazy var cardsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = -40
        layout.minimumInteritemSpacing = 5
        let width: CGFloat = 160
        layout.itemSize = CGSize(width: width, height: 205)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CardsCell.self, forCellWithReuseIdentifier: "CardsCell")
        cv.dataSource = self
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private let piggyBankView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemYellow
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemPink.cgColor
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pigybank")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .systemPink
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My Piggy Bank"
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .label
        label.textAlignment = .center
        
        let pigyBalanceLabel = UILabel()
        pigyBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
        pigyBalanceLabel.text = "$0.00 $"
        pigyBalanceLabel.font = .systemFont(ofSize: 19, weight: .bold)
        pigyBalanceLabel.textColor = .label
            
        view.addSubview(pigyBalanceLabel)
        view.addSubview(imageView)
        view.addSubview(label)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 2),
            label.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            pigyBalanceLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 3),
            pigyBalanceLabel.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            pigyBalanceLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25),
        ])
        return view
    }()
    private let coinsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemYellow
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemPink.cgColor
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "coin")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .systemPink
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Swift Coins"
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .label
        label.textAlignment = .center
        
        let pigyBalanceLabel = UILabel()
        pigyBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
        pigyBalanceLabel.text = "170 Coin"
        pigyBalanceLabel.font = .systemFont(ofSize: 19, weight: .bold)
        pigyBalanceLabel.textColor = .label
            
        view.addSubview(pigyBalanceLabel)
        view.addSubview(imageView)
        view.addSubview(label)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 2),
            label.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            pigyBalanceLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 3),
            pigyBalanceLabel.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            pigyBalanceLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25),
        ])
        return view
    }()
    private let quickAccessTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Quick Access"
        lbl.font = .systemFont(ofSize: 18, weight: .medium)
        lbl.textColor = .black
        return lbl
    }()
    private let airTimeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("AirTime", for: .normal)
        btn.setImage(UIImage(systemName: "phone.fill"), for: .normal)

        btn.tintColor = .label
        btn.setTitleColor(.label, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)

        btn.backgroundColor = .secondarySystemBackground
        btn.layer.cornerRadius = 20
        btn.translatesAutoresizingMaskIntoConstraints = false

        btn.semanticContentAttribute = .forceLeftToRight
        btn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 4)

        btn.setPreferredSymbolConfiguration(
            UIImage.SymbolConfiguration(pointSize: 16, weight: .medium),
            forImageIn: .normal
        )

        return btn
    }()

    private let bettingButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Betting", for: .normal)
        btn.setImage(UIImage(systemName: "soccerball"), for: .normal)

        btn.tintColor = .label
        btn.setTitleColor(.label, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)

        btn.backgroundColor = .secondarySystemBackground
        btn.layer.cornerRadius = 20
        btn.translatesAutoresizingMaskIntoConstraints = false

        btn.semanticContentAttribute = .forceLeftToRight
        btn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 4)

        btn.setPreferredSymbolConfiguration(
            UIImage.SymbolConfiguration(pointSize: 16, weight: .medium),
            forImageIn: .normal
        )

        return btn
    }()

    private let investButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Invest", for: .normal)
        btn.setImage(UIImage(systemName: "chart.line.uptrend.xyaxis"), for: .normal)

        btn.tintColor = .label
        btn.setTitleColor(.label, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)

        btn.backgroundColor = .secondarySystemBackground
        btn.layer.cornerRadius = 20
        btn.translatesAutoresizingMaskIntoConstraints = false

        btn.semanticContentAttribute = .forceLeftToRight
        btn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 4)

        btn.setPreferredSymbolConfiguration(
            UIImage.SymbolConfiguration(pointSize: 16, weight: .medium),
            forImageIn: .normal
        )

        return btn
    }()

    private let bottomSpacer: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        setupUI()
        populateUserInfo()
    }
    
    
    
    
    private func setupUI() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
     
        NSLayoutConstraint.activate([
            scrollView.contentLayoutGuide.widthAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.widthAnchor
            )
        ])

        
        
        scrollView.addSubview(profileBtn)
        scrollView.addSubview(balanceTitleLabel)
        scrollView.addSubview(balanceLabel)
        scrollView.addSubview(mobileButton)
        scrollView.addSubview(mobileTitleLabel)
        scrollView.addSubview(transferMoneyButton)
        scrollView.addSubview(transferMoneyTitleLabel)
        scrollView.addSubview(claimMoneyButton)
        scrollView.addSubview(claimMoneyTitleLabel)
        scrollView.addSubview(myCardButton)
        scrollView.addSubview(myCardTitleLabel)
        scrollView.addSubview(cardsCollectionView)
        scrollView.addSubview(piggyBankView)
        scrollView.addSubview(coinsView)
        scrollView.addSubview(quickAccessTitleLabel)
        scrollView.addSubview(airTimeButton)
        scrollView.addSubview(bettingButton)
        scrollView.addSubview(investButton)
        scrollView.addSubview(bottomSpacer)
        
        NSLayoutConstraint.activate([
            profileBtn.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 12),
            profileBtn.heightAnchor.constraint(equalToConstant: 40),
            profileBtn.leadingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.leadingAnchor,
                constant: 16
            )

         
        ])
        
        NSLayoutConstraint.activate([
            balanceTitleLabel.topAnchor.constraint(equalTo: profileBtn.bottomAnchor, constant: 24),
            balanceTitleLabel.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 16),
            balanceTitleLabel.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -16),

            balanceLabel.topAnchor.constraint(equalTo: balanceTitleLabel.bottomAnchor, constant: 4),
            balanceLabel.leadingAnchor.constraint(equalTo: balanceTitleLabel.leadingAnchor),
            balanceLabel.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            mobileButton.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 24),
            mobileButton.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 24),
            mobileButton.widthAnchor.constraint(equalToConstant: 64),
            mobileButton.heightAnchor.constraint(equalToConstant: 64),
            
            transferMoneyButton.centerYAnchor.constraint(equalTo: mobileButton.centerYAnchor),
            transferMoneyButton.leadingAnchor.constraint(equalTo: mobileButton.trailingAnchor, constant: 32),
            transferMoneyButton.widthAnchor.constraint(equalTo: mobileButton.widthAnchor),
            transferMoneyButton.heightAnchor.constraint(equalTo: mobileButton.heightAnchor),
            
            claimMoneyButton.centerYAnchor.constraint(equalTo: transferMoneyButton.centerYAnchor),
            claimMoneyButton.leadingAnchor.constraint(equalTo: transferMoneyButton.trailingAnchor, constant: 32),
            claimMoneyButton.widthAnchor.constraint(equalTo: transferMoneyButton.widthAnchor),
            claimMoneyButton.heightAnchor.constraint(equalTo: transferMoneyButton.heightAnchor),
            
            myCardButton.centerYAnchor.constraint(equalTo: claimMoneyButton.centerYAnchor),
            myCardButton.leadingAnchor.constraint(equalTo: claimMoneyButton.trailingAnchor, constant: 32),
            myCardButton.widthAnchor.constraint(equalTo: claimMoneyButton.widthAnchor),
            myCardButton.heightAnchor.constraint(equalTo: claimMoneyButton.heightAnchor),
            myCardButton.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -24),
            
            mobileTitleLabel.topAnchor.constraint(equalTo: mobileButton.bottomAnchor, constant: 6),
            mobileTitleLabel.centerXAnchor.constraint(equalTo: mobileButton.centerXAnchor),
            mobileTitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 8),
            mobileTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -8),
            
            transferMoneyTitleLabel.topAnchor.constraint(equalTo: transferMoneyButton.bottomAnchor, constant: 6),
            transferMoneyTitleLabel.centerXAnchor.constraint(equalTo: transferMoneyButton.centerXAnchor),
            transferMoneyTitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 8),
            transferMoneyTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -8),
            
            claimMoneyTitleLabel.topAnchor.constraint(equalTo: claimMoneyButton.bottomAnchor, constant: 6),
            claimMoneyTitleLabel.centerXAnchor.constraint(equalTo: claimMoneyButton.centerXAnchor),
            claimMoneyTitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 8),
            claimMoneyTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -8),
            
            myCardTitleLabel.topAnchor.constraint(equalTo: myCardButton.bottomAnchor, constant: 6),
            myCardTitleLabel.centerXAnchor.constraint(equalTo: myCardButton.centerXAnchor),
            myCardTitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 8),
            myCardTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -8),
            
            
        ])
        
        NSLayoutConstraint.activate([
            cardsCollectionView.topAnchor.constraint(equalTo: myCardTitleLabel.bottomAnchor, constant: 24),
            cardsCollectionView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            cardsCollectionView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            cardsCollectionView.heightAnchor.constraint(equalToConstant: 165)
        ])

        NSLayoutConstraint.activate([
            piggyBankView.topAnchor.constraint(equalTo: cardsCollectionView.bottomAnchor, constant: 8),
            piggyBankView.leadingAnchor.constraint(equalTo: mobileButton.leadingAnchor),
            piggyBankView.heightAnchor.constraint(equalToConstant: 120),
            piggyBankView.widthAnchor.constraint(equalToConstant: 165)
        ])
       
        NSLayoutConstraint.activate([
            coinsView.topAnchor.constraint(equalTo: cardsCollectionView.bottomAnchor, constant: 8),
            coinsView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -24),
            coinsView.heightAnchor.constraint(equalToConstant: 120),
            coinsView.widthAnchor.constraint(equalToConstant: 165)
        ])
        
        NSLayoutConstraint.activate([
            quickAccessTitleLabel.topAnchor.constraint(equalTo: piggyBankView.bottomAnchor, constant: 20),
            quickAccessTitleLabel.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 16),
            quickAccessTitleLabel.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        let buttonWidth: CGFloat = 100
        
        NSLayoutConstraint.activate([
            airTimeButton.topAnchor.constraint(equalTo: quickAccessTitleLabel.bottomAnchor, constant: 12),
            airTimeButton.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 16),
            airTimeButton.heightAnchor.constraint(equalToConstant: 36),
            airTimeButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            
            bettingButton.centerYAnchor.constraint(equalTo: airTimeButton.centerYAnchor),
            bettingButton.leadingAnchor.constraint(equalTo: airTimeButton.trailingAnchor, constant: 12),
            bettingButton.heightAnchor.constraint(equalTo: airTimeButton.heightAnchor),
            bettingButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            
            investButton.centerYAnchor.constraint(equalTo: airTimeButton.centerYAnchor),
            investButton.leadingAnchor.constraint(equalTo: bettingButton.trailingAnchor, constant: 12),
            investButton.heightAnchor.constraint(equalToConstant: 44),
            investButton.widthAnchor.constraint(equalToConstant: buttonWidth),
        ])
        
        NSLayoutConstraint.activate([
            bottomSpacer.topAnchor.constraint(equalTo: investButton.bottomAnchor, constant: 24),
            bottomSpacer.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            bottomSpacer.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            bottomSpacer.heightAnchor.constraint(equalToConstant: 40),
            bottomSpacer.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            scrollView.contentLayoutGuide.widthAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.widthAnchor
            )
        ])



        profileBtn.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
        mobileButton.addTarget(self, action: #selector(didTapMobileDeposit), for: .touchUpInside)
        transferMoneyButton.addTarget(self, action: #selector(didTapTransferMoney), for: .touchUpInside)
        airTimeButton.addTarget(self, action: #selector(didTapAirTime), for: .touchUpInside)
        bettingButton.addTarget(self, action: #selector(didTapBetting), for: .touchUpInside)
        investButton.addTarget(self, action: #selector(didTapInvest), for: .touchUpInside)
        
        let coinTap = UITapGestureRecognizer(target: self, action: #selector(didTapCoins))
        piggyBankView.isUserInteractionEnabled = true
        piggyBankView.addGestureRecognizer(coinTap)
        
        let piggyTap = UITapGestureRecognizer(target: self, action: #selector(didTapPiggyBank))
        piggyBankView.isUserInteractionEnabled = true
        piggyBankView.addGestureRecognizer(piggyTap)
    }
    
    private func populateUserInfo() {
        let email = Auth.auth().currentUser?.email
        let title = email ?? "No user"
        profileBtn.setTitle(" \(title)", for: .normal)
    }
    
    @objc private func didTapProfile() {
        let vc = ProfileVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapMobileDeposit() {}
    @objc private func didTapTransferMoney() {}
    @objc private func didTapPiggyBank() {
        let vc = ProfileVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func didTapCoins() {
        let vc = ProfileVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func didTapAirTime() {
        
    }
    @objc private func didTapBetting() {
        
    }
    @objc private func didTapInvest() {
        
    }
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardsCell", for: indexPath) as! CardsCell
        return cell
    }
}

//import SwiftUI
//#Preview {
//    UINavigationController(rootViewController: MainVC())
//}
#warning("transfer money da claim moneys labelebi gasasworebelia ")
