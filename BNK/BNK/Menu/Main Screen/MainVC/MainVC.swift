//
//  MainVC.swift
//  BNK
//
//  Created by chasemedkcorto on 30.01.26.
//
import UIKit
import FirebaseAuth
import WebKit
import SafariServices

class MainVC: UIViewController, WKUIDelegate, UIGestureRecognizerDelegate {
    
    private let scrollView : UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .systemBackground
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.isScrollEnabled = true
        sv.showsVerticalScrollIndicator = true
        sv.showsHorizontalScrollIndicator = false
        sv.delaysContentTouches = false
        sv.canCancelContentTouches = true
        return sv
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let aiOrbButton: AIOrbButton = {
        let button = AIOrbButton(diameter: 68)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.separator.cgColor
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
    
    private lazy var cardsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = -40
        layout.minimumInteritemSpacing = 5
        let width: CGFloat = 160
        layout.itemSize = CGSize(width: 160, height: 205)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CardsCell.self, forCellWithReuseIdentifier: "CardsCell")
        cv.dataSource = self
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        cv.delaysContentTouches = false
        return cv
    }()
    private var offers: [Offer] = []
    private let CardMannager = CardManager()
    private let piggyBankView: FuturisticInfoCard = {
        let view = FuturisticInfoCard(
            title: "My Piggy Bank",
            value: "$0.00 $",
            symbolName: "banknote.fill",
            gradientColors: [.systemTeal, .systemIndigo],
            accentColors: [.systemCyan, .systemPurple]
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let coinsView: UIView = {
        let view = FuturisticInfoCard(
            title: "Swift Coins",
            value: "170 Coin",
            symbolName: "bitcoinsign.circle.fill",
            gradientColors: [
                UIColor.systemYellow, UIColor.systemOrange
            ],
            accentColors: [
                UIColor.systemPink, UIColor.systemOrange
            ]
        )
        view.translatesAutoresizingMaskIntoConstraints = false
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
    
    public let addCardBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Add Card", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        btn.backgroundColor = .black
        btn.layer.cornerCurve = .continuous
        btn.layer.cornerRadius = 22
        btn.contentEdgeInsets = UIEdgeInsets(top: 18, left: 20, bottom: 18, right: 20)
        btn.setImage(UIImage(systemName: "plus"), for: .normal)
        btn.tintColor = .white
        btn.semanticContentAttribute = .forceLeftToRight
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 6)
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.12
        btn.layer.shadowOffset = CGSize(width: 0, height: 6)
        btn.layer.shadowRadius = 12
        return btn
    }()
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.bringSubviewToFront(aiOrbButton)
    }

    private var injectedCardView: Card?
    private var cardsCollectionTopConstraint: NSLayoutConstraint?

    private let tableMinHeight: CGFloat = 500
    private let heightDeadzone: CGFloat = 0.5
    private var pendingHeightUpdate = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        populateUserInfo()
        setupAddCard()
        CardMannager.getCardCellData { [weak self] loadedOffers in
              guard let self = self else { return }
              
              DispatchQueue.main.async {
                  self.offers = loadedOffers
                  self.cardsCollectionView.reloadData()
              }
          }
        // Gestures: allow simultaneous recognition
        scrollView.panGestureRecognizer.cancelsTouchesInView = false

        // Insets so outer scroll has space at bottom
        scrollView.contentInset.bottom = 24
        scrollView.verticalScrollIndicatorInsets.bottom = 24

        // Initial minimum height
        tableViewHeightConstraint?.constant = tableMinHeight
        view.layoutIfNeeded()

        DispatchQueue.main.async { [weak self] in
            self?.updateTableViewHeight()
        }
    }

    // Gesture recognizer delegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        populateUserInfo()
        updateTableViewHeight()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateTableViewHeight()
    }

    private func updateTableViewHeight() {
        if pendingHeightUpdate { return }
        pendingHeightUpdate = true

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.todayTableView.layoutIfNeeded()
            let intrinsic = self.todayTableView.contentSize.height
            let target = max(intrinsic, self.tableMinHeight)
            if let current = self.tableViewHeightConstraint?.constant, abs(current - target) < self.heightDeadzone {
                self.pendingHeightUpdate = false
                return
            }
            self.tableViewHeightConstraint?.constant = target
            UIView.performWithoutAnimation {
                self.view.layoutIfNeeded()
            }
            self.scrollView.layoutIfNeeded()
            self.pendingHeightUpdate = false
        }
    }

    private func setupAddCard() {
        NSLayoutConstraint.activate([
            addCardBtn.topAnchor.constraint(equalTo: mobileButton.bottomAnchor, constant: 60),
            addCardBtn.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            addCardBtn.heightAnchor.constraint(equalToConstant: 60),
            addCardBtn.widthAnchor.constraint(equalToConstant: 320),
        ])
    }
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(addCardBtn)
        view.addSubview(aiOrbButton)

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
        contentView.addSubview(piggyBankView)
        contentView.addSubview(coinsView)
        contentView.addSubview(quickAccessTitleLabel)
        contentView.addSubview(airTimeButton)
        contentView.addSubview(bettingButton)
        contentView.addSubview(investButton)
        contentView.addSubview(todayLabel)
        contentView.addSubview(todayTableView)
        contentView.addSubview(cardsCollectionView)

        NSLayoutConstraint.activate([
            profileBtn.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 6),
            profileBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileBtn.heightAnchor.constraint(equalToConstant: 40)
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
            mobileButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60),
            mobileButton.widthAnchor.constraint(equalToConstant: 64),
            mobileButton.heightAnchor.constraint(equalToConstant: 64),

            transferMoneyButton.centerYAnchor.constraint(equalTo: mobileButton.centerYAnchor),
            transferMoneyButton.leadingAnchor.constraint(equalTo: mobileButton.trailingAnchor, constant: 40),
            transferMoneyButton.widthAnchor.constraint(equalTo: mobileButton.widthAnchor),
            transferMoneyButton.heightAnchor.constraint(equalTo: mobileButton.heightAnchor),

            claimMoneyButton.centerYAnchor.constraint(equalTo: mobileButton.centerYAnchor),
            claimMoneyButton.leadingAnchor.constraint(equalTo: transferMoneyButton.trailingAnchor, constant: 40),
            claimMoneyButton.widthAnchor.constraint(equalTo: mobileButton.widthAnchor),
            claimMoneyButton.heightAnchor.constraint(equalTo: mobileButton.heightAnchor),
            claimMoneyButton.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),

            mobileTitleLabel.topAnchor.constraint(equalTo: mobileButton.bottomAnchor, constant: 6),
            mobileTitleLabel.centerXAnchor.constraint(equalTo: mobileButton.centerXAnchor),
            mobileTitleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 120),

            transferMoneyTitleLabel.topAnchor.constraint(equalTo: transferMoneyButton.bottomAnchor, constant: 6),
            transferMoneyTitleLabel.centerXAnchor.constraint(equalTo: transferMoneyButton.centerXAnchor),
            transferMoneyTitleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 120),

            claimMoneyTitleLabel.topAnchor.constraint(equalTo: claimMoneyButton.bottomAnchor, constant: 6),
            claimMoneyTitleLabel.centerXAnchor.constraint(equalTo: claimMoneyButton.centerXAnchor),
            claimMoneyTitleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 120)
        ])
    
        let initialTop = cardsCollectionView.topAnchor.constraint(equalTo: addCardBtn.bottomAnchor, constant: 10)
        cardsCollectionTopConstraint = initialTop
        NSLayoutConstraint.activate([
            initialTop,
            cardsCollectionView.topAnchor.constraint(equalTo: addCardBtn.bottomAnchor, constant: 20),
            cardsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardsCollectionView.heightAnchor.constraint(equalToConstant: 210) 
        ])

        NSLayoutConstraint.activate([
            piggyBankView.topAnchor.constraint(equalTo: cardsCollectionView.bottomAnchor, constant: 8),
            piggyBankView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
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
        
        tableViewHeightConstraint = todayTableView.heightAnchor.constraint(equalToConstant: tableMinHeight)
        tableViewHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            todayTableView.topAnchor.constraint(equalTo: todayLabel.bottomAnchor, constant: 12),
            todayTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            todayTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            todayTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
        //AI ORB BUTTOn
        NSLayoutConstraint.activate([
            aiOrbButton.widthAnchor.constraint(equalToConstant: 68),
            aiOrbButton.heightAnchor.constraint(equalToConstant: 68),

            aiOrbButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            aiOrbButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])

        addCardBtn.addTarget(self, action: #selector(didTapAddCard), for: .touchUpInside)
        mobileButton.addTarget(self, action: #selector(didTapDepTelephone), for: .touchUpInside)
        profileBtn.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
        transferMoneyButton.addTarget(self, action: #selector(didTapTransferMoney), for: .touchUpInside)
        airTimeButton.addTarget(self, action: #selector(didTapAirTime), for: .touchUpInside)
        bettingButton.addTarget(self, action: #selector(didTapBetting), for: .touchUpInside)
        investButton.addTarget(self, action: #selector(didTapInvest), for: .touchUpInside)
        claimMoneyButton.addTarget(self, action: #selector(didTapClaimMoneyButton), for: .touchUpInside)
        aiOrbButton.addTarget(self, action: #selector(didTapAIOrb), for: .touchUpInside)

        let piggyTap = UITapGestureRecognizer(target: self, action: #selector(didTapPiggyBank))
        piggyTap.cancelsTouchesInView = false
        piggyBankView.isUserInteractionEnabled = true
        piggyBankView.addGestureRecognizer(piggyTap)
        
        let coinTap = UITapGestureRecognizer(target: self, action: #selector(didTapCoins))
        coinTap.cancelsTouchesInView = false
        coinsView.isUserInteractionEnabled = true
        coinsView.addGestureRecognizer(coinTap)
    }
    @objc
    private func didTapAIOrb() {
        let vc = ChatViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func populateUserInfo() {
        let displayName = Auth.auth().currentUser?.displayName?.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = Auth.auth().currentUser?.email?.trimmingCharacters(in: .whitespacesAndNewlines)
        let title = (displayName?.isEmpty == false ? displayName : email) ?? "User"
        DispatchQueue.main.async {
            self.profileBtn.setTitle(" \(title)", for: .normal)
        }
    }
    private func GetCardData() {
        CardMannager.getCardCellData { [weak self] loadedOffers in
            DispatchQueue.main.async {
                self?.offers = loadedOffers
                self?.cardsCollectionView.reloadData()
            }
        }
    }
//    func getCardPressed() {
//        CardManager.getCardCellData { [weak self] offers in
//            DispatchQueue.main.async {
//                self?.offers = offers
//                self?.cardsCollectionView.reloadData()
//            }
//        }
    @objc private func didTapProfile() {
        let vc = ProfileVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func didTapDepTelephone() {
        let vc = DPTVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func didTapTransferMoney() {
        let vc = TranferMoneyVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func didTapClaimMoneyButton() {
        let vc = AddMoneyVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func didTapPiggyBank() {
        let vc = ProfileVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func didTapCoins() {
        let vc = ProfileVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func didTapAirTime() {
        let vc = AirTimeWebkitVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func didTapBetting() {
        let vc = BetWebkitVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func didTapInvest() {
        let vc = investWebkitVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func didTapAddCard() {
        let vc = AddCardVc()
        vc.delegate = self
        vc.modalPresentationStyle = .pageSheet

        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 24
            sheet.largestUndimmedDetentIdentifier = .large
        }

        present(vc, animated: true)
    }
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardsCell", for: indexPath) as! CardsCell
        if indexPath.item < offers.count {
              let currentCard = offers[indexPath.item]
              cell.configure(with: currentCard)
          } else {

          }
        return cell
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    //სამწუხაროდ პირფველ 10ს წამოიღებს შაფლის ვერსია უნდა გავაკეთოთ და მოვიძიოთ რო ყოველთვის სხვადსხვა 10 წამოიღოს 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell") as! TransactionCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension MainVC: ButtonDelegate {
    func didTapButton(with view: Card) {
        cardsCollectionTopConstraint?.isActive = false
        
        injectedCardView?.removeFromSuperview()
        injectedCardView = view
        
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: mobileButton.bottomAnchor, constant: 45),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardsCollectionView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
        ])
        
        if addCardBtn.superview != nil {
            addCardBtn.removeFromSuperview()
        }
        let newTop = cardsCollectionView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 56)
        cardsCollectionTopConstraint = newTop
        newTop.isActive = true

        UIView.performWithoutAnimation {
            self.view.layoutIfNeeded()
        }
        DispatchQueue.main.async { [weak self] in
            self?.updateTableViewHeight()
        }
    }
}
//safari Services პასუხსიმგებელია პოსტერ აპის ვებსაიტ ურლზე გადასასვლელად
extension MainVC {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item < offers.count else { return }
        
        let selectedOffer = offers[indexPath.item]
        
        guard let url = URL(string: selectedOffer.websiteURL) else {
            print("Invalid URL string: \(selectedOffer.websiteURL)")
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.modalPresentationStyle = .pageSheet
        self.present(safariVC, animated: true, completion: nil)
    }
}
#warning("ProfileButtonshi unda sheicvalos saxeli da daeweros saxeli romelitac shevedit")
#warning("damate scan card ")
#warning("randomizer api posteer gvinda sadac nebismieri posteri gamochndeba sxvadasxva grafaze")
