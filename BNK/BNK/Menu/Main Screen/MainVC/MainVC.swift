//
//  MainVC.swift
//  BNK
//
//  Created by chasemedkcorto on 30.01.26.
//
import UIKit
import FirebaseAuth
import FirebaseFirestore
import WebKit
import SafariServices

class MainVC: UIViewController, WKUIDelegate, UIGestureRecognizerDelegate {
    // Spacing and sizing
    private let headerSpacing: CGFloat = 12
    private let sectionSpacing: CGFloat = 24
    private let cardSize = CGSize(width: 280, height: 160)
    private let cardSpacing: CGFloat = 12
    private let sideMargin: CGFloat = 20

    // Scroll containers
    private let scrollView: UIScrollView = {
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

    // Floating AI button
    private let aiOrbButton: AIOrbButton = {
        let button = AIOrbButton(diameter: 68)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // Header
    private let profileBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("", for: .normal)
        btn.tintColor = UIColor(red: 0.086, green: 0.094, blue: 0.114, alpha: 1.0)
        btn.setTitleColor(.label, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .secondarySystemBackground
        btn.layer.cornerRadius = 20
        btn.clipsToBounds = true
        btn.titleLabel?.lineBreakMode = .byTruncatingMiddle
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.separator.cgColor
        return btn
    }()
    
    private let welcomeLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Welcome"
        lb.textColor = .gray
        lb.font = .systemFont(ofSize: 12)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    } ()
    private let nameLabel: UILabel = {
        let lb = UILabel()
        lb.text = ""
        lb.textColor = .label
        lb.font = .systemFont(ofSize: 15, weight: .semibold)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    private let notifyButton: UIButton = {
        var c = UIButton.Configuration.plain()
        c.image = UIImage(systemName: "bell")
        c.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 15, weight: .regular)
        c.baseForegroundColor = .label
        c.background.strokeColor = .separator
        c.background.strokeWidth = 1
        c.background.cornerRadius = 40
        let btn = UIButton(configuration: c)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.accessibilityLabel = "Notifications"
        return btn
    }()

    // Balance
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
        lbl.text = "$0.00"
        lbl.font = .systemFont(ofSize: 28, weight: .bold)
        lbl.textColor = .label
        return lbl
    }()

    // “My Cards” (title + button)
    private let myCardsTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "My Cards"
        lbl.font = .systemFont(ofSize: 18, weight: .semibold)
        lbl.textColor = .label
        return lbl
    }()
    
    public let createVirtualCardButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Create Virtual Card", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        btn.backgroundColor = .white
        btn.layer.cornerCurve = .continuous
        btn.layer.cornerRadius = 25
        btn.contentEdgeInsets = UIEdgeInsets(top: 18, left: 20, bottom: 18, right: 20)
        btn.setImage(UIImage(systemName: "creditcard.fill"), for: .normal)
        btn.tintColor = .black
        btn.semanticContentAttribute = .forceLeftToRight
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 6)
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 1.0
        btn.layer.shadowOpacity = 0.10
        btn.layer.shadowOffset = CGSize(width: 0, height: 6)
        btn.layer.shadowRadius = 12
        btn.setPreferredSymbolConfiguration(
            UIImage.SymbolConfiguration(pointSize: 14, weight: .regular),
            forImageIn: .normal
        )
        return btn
    }()

    // Quick actions
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
    
    private let quickActionGap: CGFloat = 40
    
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
        btn.setImage(UIImage(systemName: "plus"), for: .normal)
        btn.tintColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .black
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

    // Offers carousel
    private lazy var cardsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = cardSize
        layout.minimumLineSpacing = cardSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: sideMargin, bottom: 0, right: sideMargin)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CardsCell.self, forCellWithReuseIdentifier: "CardsCell")
        cv.dataSource = self
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        cv.delaysContentTouches = false
        cv.decelerationRate = .fast
        cv.clipsToBounds = false
        cv.layer.cornerRadius = 16
        cv.layer.cornerCurve = .continuous
        return cv
    }()
    
    private var offers: [Offer] = []
    private let cardManager = CardManager()

    // Quick access row title
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
        btn.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 16, weight: .medium), forImageIn: .normal)
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
        btn.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 16, weight: .medium), forImageIn: .normal)
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
        btn.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 16, weight: .medium), forImageIn: .normal)
        return btn
    }()

    // Today section
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
    private var offersTitleTopConstraint: NSLayoutConstraint?

    // Offers title
    private let offersTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Offers"
        lbl.font = .systemFont(ofSize: 18, weight: .medium)
        lbl.textColor = .label
        return lbl
    }()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.bringSubviewToFront(aiOrbButton)
    }

    private var injectedCardView: Card?

    private let tableMinHeight: CGFloat = 500
    private let heightDeadzone: CGFloat = 0.5
    private var pendingHeightUpdate = false

    private var balanceListener: ListenerRegistration?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        populateUserInfo()
        getCardData()
        
        scrollView.panGestureRecognizer.cancelsTouchesInView = false
        scrollView.contentInset.bottom = 24
        scrollView.verticalScrollIndicatorInsets.bottom = 24

        tableViewHeightConstraint?.constant = tableMinHeight
        view.layoutIfNeeded()
        populateUserInfo()
        DispatchQueue.main.async { [weak self] in
            self?.updateTableViewHeight()
        }

        startBalanceListener()
    }

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

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopBalanceListener()
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

    private func setupUI() {
        // Containers
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        view.addSubview(aiOrbButton)
    
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])

        // Header
        contentView.addSubview(profileBtn)
        contentView.addSubview(notifyButton)
        contentView.addSubview(welcomeLabel)
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            profileBtn.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 6),
            profileBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileBtn.widthAnchor.constraint(equalToConstant: 40),
            profileBtn.heightAnchor.constraint(equalToConstant: 42),
            
            welcomeLabel.topAnchor.constraint(equalTo: profileBtn.topAnchor, constant:5),
            welcomeLabel.leadingAnchor.constraint(equalTo: profileBtn.leadingAnchor,constant: 45),
            
            nameLabel.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20),
            notifyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            notifyButton.centerYAnchor.constraint(equalTo: profileBtn.centerYAnchor),
            notifyButton.heightAnchor.constraint(equalToConstant: 45),
            notifyButton.widthAnchor.constraint(equalToConstant: 45)
        ])

        // Make nameLabel tappable instead of using addTarget (UILabel isn’t a UIControl)
        let nameTap = UITapGestureRecognizer(target: self, action: #selector(didTapProfile))
        nameLabel.isUserInteractionEnabled = true
        nameLabel.addGestureRecognizer(nameTap)

        // Balance
        contentView.addSubview(balanceTitleLabel)
        contentView.addSubview(balanceLabel)
        NSLayoutConstraint.activate([
            balanceTitleLabel.topAnchor.constraint(equalTo: profileBtn.bottomAnchor, constant: sectionSpacing),
            balanceTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            balanceTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            balanceLabel.topAnchor.constraint(equalTo: balanceTitleLabel.bottomAnchor, constant: 4),
            balanceLabel.leadingAnchor.constraint(equalTo: balanceTitleLabel.leadingAnchor),
            balanceLabel.trailingAnchor.constraint(equalTo: balanceTitleLabel.trailingAnchor)
        ])

        // Quick actions row
        contentView.addSubview(mobileButton)
        contentView.addSubview(transferMoneyButton)
        contentView.addSubview(claimMoneyButton)
        contentView.addSubview(mobileTitleLabel)
        contentView.addSubview(transferMoneyTitleLabel)
        contentView.addSubview(claimMoneyTitleLabel)
        
        NSLayoutConstraint.activate([
            mobileButton.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: sectionSpacing),
            mobileButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60),
            mobileButton.widthAnchor.constraint(equalToConstant: 64),
            mobileButton.heightAnchor.constraint(equalToConstant: 64),

            transferMoneyButton.centerYAnchor.constraint(equalTo: mobileButton.centerYAnchor),
            transferMoneyButton.leadingAnchor.constraint(equalTo: mobileButton.trailingAnchor, constant: quickActionGap),
            transferMoneyButton.widthAnchor.constraint(equalTo: mobileButton.widthAnchor),
            transferMoneyButton.heightAnchor.constraint(equalTo: mobileButton.heightAnchor),

            claimMoneyButton.centerYAnchor.constraint(equalTo: mobileButton.centerYAnchor),
            claimMoneyButton.leadingAnchor.constraint(equalTo: transferMoneyButton.trailingAnchor, constant: quickActionGap),
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

        // My Cards section
        contentView.addSubview(myCardsTitleLabel)
        contentView.addSubview(createVirtualCardButton)
        NSLayoutConstraint.activate([
            myCardsTitleLabel.topAnchor.constraint(equalTo: claimMoneyTitleLabel.bottomAnchor, constant: sectionSpacing),
            myCardsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            myCardsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            createVirtualCardButton.topAnchor.constraint(equalTo: myCardsTitleLabel.bottomAnchor, constant: 12),
            createVirtualCardButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            createVirtualCardButton.heightAnchor.constraint(equalToConstant: 50),
            createVirtualCardButton.widthAnchor.constraint(equalToConstant: 280)
        ])

        // Offers section title
        contentView.addSubview(offersTitleLabel)
        let defaultOffersTop = offersTitleLabel.topAnchor.constraint(equalTo: createVirtualCardButton.bottomAnchor, constant: 5)
        self.offersTitleTopConstraint = defaultOffersTop
        
        NSLayoutConstraint.activate([
            defaultOffersTop,
            offersTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            offersTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])

        // Offers carousel
        contentView.addSubview(cardsCollectionView)
        NSLayoutConstraint.activate([
            cardsCollectionView.topAnchor.constraint(equalTo: offersTitleLabel.bottomAnchor, constant: headerSpacing),
            cardsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardsCollectionView.heightAnchor.constraint(equalToConstant: cardSize.height)
        ])

        // Quick Access section
        contentView.addSubview(quickAccessTitleLabel)
        contentView.addSubview(airTimeButton)
        contentView.addSubview(bettingButton)
        contentView.addSubview(investButton)
        NSLayoutConstraint.activate([
            quickAccessTitleLabel.topAnchor.constraint(equalTo: cardsCollectionView.bottomAnchor, constant: 20),
            quickAccessTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            quickAccessTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])

        let smallButtonWidth: CGFloat = 100
        NSLayoutConstraint.activate([
            airTimeButton.topAnchor.constraint(equalTo: quickAccessTitleLabel.bottomAnchor, constant: 12),
            airTimeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            airTimeButton.heightAnchor.constraint(equalToConstant: 36),
            airTimeButton.widthAnchor.constraint(equalToConstant: smallButtonWidth),

            bettingButton.centerYAnchor.constraint(equalTo: airTimeButton.centerYAnchor),
            bettingButton.leadingAnchor.constraint(equalTo: airTimeButton.trailingAnchor, constant: 12),
            bettingButton.heightAnchor.constraint(equalTo: airTimeButton.heightAnchor),
            bettingButton.widthAnchor.constraint(equalToConstant: smallButtonWidth),

            investButton.centerYAnchor.constraint(equalTo: airTimeButton.centerYAnchor),
            investButton.leadingAnchor.constraint(equalTo: bettingButton.trailingAnchor, constant: 12),
            investButton.heightAnchor.constraint(equalTo: airTimeButton.heightAnchor),
            investButton.widthAnchor.constraint(equalToConstant: smallButtonWidth)
        ])

        // Today section
        contentView.addSubview(todayLabel)
        contentView.addSubview(todayTableView)
        NSLayoutConstraint.activate([
            todayLabel.topAnchor.constraint(equalTo: airTimeButton.bottomAnchor, constant: sectionSpacing),
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

        // Floating AI button
        NSLayoutConstraint.activate([
            aiOrbButton.widthAnchor.constraint(equalToConstant: 68),
            aiOrbButton.heightAnchor.constraint(equalToConstant: 68),
            aiOrbButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            aiOrbButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])

        // Actions
        mobileButton.addTarget(self, action: #selector(didTapDepTelephone), for: .touchUpInside)
        transferMoneyButton.addTarget(self, action: #selector(didTapTransferMoney), for: .touchUpInside)
        airTimeButton.addTarget(self, action: #selector(didTapAirTime), for: .touchUpInside)
        bettingButton.addTarget(self, action: #selector(didTapBetting), for: .touchUpInside)
        investButton.addTarget(self, action: #selector(didTapInvest), for: .touchUpInside)
        claimMoneyButton.addTarget(self, action: #selector(didTapClaimMoneyButton), for: .touchUpInside)
        aiOrbButton.addTarget(self, action: #selector(didTapAIOrb), for: .touchUpInside)
        createVirtualCardButton.addTarget(self, action: #selector(didTapCreateVirtualCard), for: .touchUpInside)
       
    }

    @objc private func didTapAIOrb() {
        let vc = ChatViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    private func setName(_ text: String) {
        DispatchQueue.main.async {
            self.nameLabel.text = text
            self.profileBtn.setTitle("", for: .normal)
        }
    }
    @objc private func populateUserInfo() {
        print("populateUserInfo called")
//        profileBtn.titleLabel = primary.first.map { String($0).uppercased() } ?? "U"

        guard let user = Auth.auth().currentUser else {
            print("currentUser is nil")
            setName("User")
            return
        }

        print("uid:", user.uid, "displayName:", user.displayName ?? "nil", "email:", user.email ?? "nil")

        let displayName = user.displayName?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if !displayName.isEmpty {
            setName(displayName)
            return
        }

        Firestore.firestore().collection("users").document(user.uid).getDocument { [weak self] snapshot, error in
            print("firestore:", snapshot?.data() ?? "nil", "error:", error?.localizedDescription ?? "none")

            let data = snapshot?.data()
            let first = data?["firstName"] as? String ?? ""
            let last = data?["lastName"] as? String ?? ""
            let fullName = "\(first) \(last)".trimmingCharacters(in: .whitespacesAndNewlines)

            self?.setName(fullName.isEmpty ? (user.email ?? "User") : fullName)
        }
    }
  
    private func getCardData() {
        cardManager.getCardCellData { [weak self] loadedOffers in
            DispatchQueue.main.async {
                self?.offers = loadedOffers
                self?.cardsCollectionView.reloadData()
            }
        }
    }

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

    @objc private func didTapCreateVirtualCard() {
        let vc = AddCardVc()
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        print("isLoggedIn:", AuthService.shared.auth.currentUser != nil)
        print("uid:", AuthService.shared.auth.currentUser?.uid as Any)
        print("setupUI done")
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 24
            sheet.largestUndimmedDetentIdentifier = .large
            
        }
        present(vc, animated: true)
    }

    private func startBalanceListener() {
        stopBalanceListener()

        guard Auth.auth().currentUser != nil else { return }
        balanceListener = AuthService.shared.addBalanceListener { [weak self] balance in
            self?.refreshBalanceLabel(with: balance)
        }
    }

    private func stopBalanceListener() {
        balanceListener?.remove()
        balanceListener = nil
    }

    private func refreshBalanceLabel(with balance: Int) {
        DispatchQueue.main.async {
            self.balanceLabel.text = String(format: "$%d.00", balance)
        }
    }
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardsCell", for: indexPath) as! CardsCell
        if indexPath.item < offers.count {
            let currentCard = offers[indexPath.item]
            cell.configure(with: currentCard)
        }
        return cell
    }
    
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

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 10 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell") as! TransactionCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 80 }
}

extension MainVC: ButtonDelegate {
    func didTapButton(with view: Card) {
        createVirtualCardButton.isHidden = true

        offersTitleTopConstraint?.isActive = false
        injectedCardView?.removeFromSuperview()
        injectedCardView = view

        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)

        NSLayoutConstraint.activate([
            // place exactly where the button was
            view.topAnchor.constraint(equalTo: createVirtualCardButton.topAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])

        let newTop = offersTitleLabel.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 24)
        offersTitleTopConstraint = newTop
        newTop.isActive = true

        UIView.performWithoutAnimation { self.view.layoutIfNeeded() }
        DispatchQueue.main.async { [weak self] in self?.updateTableViewHeight() }
    }
}
#warning("ProfileButtonshi unda sheicvalos saxeli da daeweros saxeli romelitac shevedit")
#warning("damate scan card ")
#warning("randomizer api posteer gvinda sadac nebismieri posteri gamochndeba sxvadasxva grafaze")

import SwiftUI
#Preview { MainVC() }

