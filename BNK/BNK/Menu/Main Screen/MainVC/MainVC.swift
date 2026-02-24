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
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        lbl.textColor = .label
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
        lbl.textColor = .label
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
        lbl.text = "Add Money"
        lbl.font = .systemFont(ofSize: 14, weight: .medium)
        lbl.textColor = .label
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
        lbl.textColor = .label
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
        lbl.textColor = .label
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

    private let todayLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "TODAY"
        lbl.font = .systemFont(ofSize: 14, weight: .bold)
        lbl.textColor = .label
        return lbl
    }()
    
    private lazy var todayTableView: UITableView = {
        let tb = UITableView()
        tb.isScrollEnabled = false
        tb.dataSource = self
        tb.delegate = self
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.estimatedRowHeight = 80
        tb.rowHeight = UITableView.automaticDimension
        tb.backgroundColor = .systemBackground
        tb.register(TransactionCell.self, forCellReuseIdentifier: "TransactionCell")
        return tb
    }()
    
    private var tableViewHeightConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        setupUI()
        populateUserInfo()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateTableViewHeight()
    }
    
    private func updateTableViewHeight() {
        todayTableView.layoutIfNeeded()
        let height = todayTableView.contentSize.height
        tableViewHeightConstraint?.constant = height
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
     
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
        
        contentView.addSubview(profileBtn)
        contentView.addSubview(balanceTitleLabel)
        contentView.addSubview(balanceLabel)
        contentView.addSubview(mobileButton)
        contentView.addSubview(mobileTitleLabel)
        contentView.addSubview(transferMoneyButton)
        contentView.addSubview(transferMoneyTitleLabel)
        contentView.addSubview(claimMoneyButton)
        contentView.addSubview(claimMoneyTitleLabel)
        contentView.addSubview(myCardButton)
        contentView.addSubview(myCardTitleLabel)
        contentView.addSubview(cardsCollectionView)
        contentView.addSubview(piggyBankView)
        contentView.addSubview(coinsView)
        contentView.addSubview(quickAccessTitleLabel)
        contentView.addSubview(airTimeButton)
        contentView.addSubview(bettingButton)
        contentView.addSubview(investButton)
        contentView.addSubview(todayLabel)
        contentView.addSubview(todayTableView)
        
        NSLayoutConstraint.activate([
            profileBtn.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            profileBtn.heightAnchor.constraint(equalToConstant: 40),
            profileBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            balanceTitleLabel.topAnchor.constraint(equalTo: profileBtn.bottomAnchor, constant: 24),
            balanceTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            balanceTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            balanceLabel.topAnchor.constraint(equalTo: balanceTitleLabel.bottomAnchor, constant: 4),
            balanceLabel.leadingAnchor.constraint(equalTo: balanceTitleLabel.leadingAnchor),
            balanceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            mobileButton.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 24),
            mobileButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
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
            myCardButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            mobileTitleLabel.topAnchor.constraint(equalTo: mobileButton.bottomAnchor, constant: 6),
            mobileTitleLabel.centerXAnchor.constraint(equalTo: mobileButton.centerXAnchor),
            mobileTitleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 80),
            
            transferMoneyTitleLabel.topAnchor.constraint(equalTo: transferMoneyButton.bottomAnchor, constant: 6),
            transferMoneyTitleLabel.centerXAnchor.constraint(equalTo: transferMoneyButton.centerXAnchor),
            transferMoneyTitleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 80),
            
            claimMoneyTitleLabel.topAnchor.constraint(equalTo: claimMoneyButton.bottomAnchor, constant: 6),
            claimMoneyTitleLabel.centerXAnchor.constraint(equalTo: claimMoneyButton.centerXAnchor),
            claimMoneyTitleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 80),
            
            myCardTitleLabel.topAnchor.constraint(equalTo: myCardButton.bottomAnchor, constant: 6),
            myCardTitleLabel.centerXAnchor.constraint(equalTo: myCardButton.centerXAnchor),
            myCardTitleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            cardsCollectionView.topAnchor.constraint(equalTo: myCardTitleLabel.bottomAnchor, constant: 24),
            cardsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardsCollectionView.heightAnchor.constraint(equalToConstant: 205)
        ])

        NSLayoutConstraint.activate([
            piggyBankView.topAnchor.constraint(equalTo: cardsCollectionView.bottomAnchor, constant: 8),
            piggyBankView.leadingAnchor.constraint(equalTo: mobileButton.leadingAnchor),
            piggyBankView.heightAnchor.constraint(equalToConstant: 120),
            piggyBankView.widthAnchor.constraint(equalToConstant: 165)
        ])
       
        NSLayoutConstraint.activate([
            coinsView.topAnchor.constraint(equalTo: cardsCollectionView.bottomAnchor, constant: 8),
            coinsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            coinsView.heightAnchor.constraint(equalToConstant: 120),
            coinsView.widthAnchor.constraint(equalToConstant: 165)
        ])
        
        NSLayoutConstraint.activate([
            quickAccessTitleLabel.topAnchor.constraint(equalTo: piggyBankView.bottomAnchor, constant: 20),
            quickAccessTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            quickAccessTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        let buttonWidth: CGFloat = 100
        
        NSLayoutConstraint.activate([
            airTimeButton.topAnchor.constraint(equalTo: quickAccessTitleLabel.bottomAnchor, constant: 12),
            airTimeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            airTimeButton.heightAnchor.constraint(equalToConstant: 36),
            airTimeButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            
            bettingButton.centerYAnchor.constraint(equalTo: airTimeButton.centerYAnchor),
            bettingButton.leadingAnchor.constraint(equalTo: airTimeButton.trailingAnchor, constant: 12),
            bettingButton.heightAnchor.constraint(equalTo: airTimeButton.heightAnchor),
            bettingButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            
            investButton.centerYAnchor.constraint(equalTo: airTimeButton.centerYAnchor),
            investButton.leadingAnchor.constraint(equalTo: bettingButton.trailingAnchor, constant: 12),
            investButton.heightAnchor.constraint(equalTo: airTimeButton.heightAnchor),
            investButton.widthAnchor.constraint(equalToConstant: buttonWidth)
        ])
        
        NSLayoutConstraint.activate([
            todayLabel.topAnchor.constraint(equalTo: airTimeButton.bottomAnchor, constant: 24),
            todayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            todayLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        tableViewHeightConstraint = todayTableView.heightAnchor.constraint(equalToConstant: 200)
        tableViewHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            todayTableView.topAnchor.constraint(equalTo: todayLabel.bottomAnchor, constant: 12),
            todayTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            todayTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            todayTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
        mobileButton.addTarget(self, action: #selector(didTapDepTelephone), for: .touchUpInside)
        profileBtn.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
        profileBtn.addTarget(self, action: #selector(populateUserInfo), for: .valueChanged)
        mobileButton.addTarget(self, action: #selector(didTapMobileDeposit), for: .touchUpInside)
        transferMoneyButton.addTarget(self, action: #selector(didTapTransferMoney), for: .touchUpInside)
        airTimeButton.addTarget(self, action: #selector(didTapAirTime), for: .touchUpInside)
        bettingButton.addTarget(self, action: #selector(didTapBetting), for: .touchUpInside)
        investButton.addTarget(self, action: #selector(didTapInvest), for: .touchUpInside)
        
        let piggyTap = UITapGestureRecognizer(target: self, action: #selector(didTapPiggyBank))
        piggyBankView.isUserInteractionEnabled = true
        piggyBankView.addGestureRecognizer(piggyTap)
        
        let coinTap = UITapGestureRecognizer(target: self, action: #selector(didTapCoins))
        coinsView.isUserInteractionEnabled = true
        coinsView.addGestureRecognizer(coinTap)
    }
    
    @objc private func populateUserInfo() {
        let email = Auth.auth().currentUser?.email
        let title = email ?? "No user"
        profileBtn.setTitle(" \(title)", for: .normal)
    }
    
    @objc private func didTapProfile() {
        let vc = ProfileVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func didTapDepTelephone() {
        let vc = DPTVC()
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

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell") as! TransactionCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
import SwiftUI
#Preview {
    UINavigationController(rootViewController: MainVC())
}

#warning("ProfileButtonshi unda sheicvalos saxeli da daeweros saxeli romelitac shevedit")
#warning("Investiciebis webkitebi")
#warning("cardis webkitebi webkitebi")
#warning("uiviewbis shecvalos randomizerit")
#warning("ლოგინს სანამ დაამთავრებ დებითქარდი უნდა დავამატოთ ")
#warning("gaakete timers daamgvale transationcellshi")
#warning("mycard vc shi create cardic sheqimnass")
