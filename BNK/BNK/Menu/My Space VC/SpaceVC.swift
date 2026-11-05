import UIKit
import FirebaseAuth
import FirebaseFirestore

final class SpaceVC: UIViewController {

    private let userHeaderButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "My Account"
        config.image = UIImage(systemName: "person.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 44, weight: .regular))
        config.imagePadding = 12
        config.imagePlacement = .leading
        config.baseForegroundColor = .label
        config.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        config.background.backgroundColor = .secondarySystemBackground
        config.background.cornerRadius = 24
        config.background.strokeColor = .separator
        config.background.strokeWidth = 1
        let btn = UIButton(configuration: config)
        btn.contentHorizontalAlignment = .leading
        btn.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        btn.titleLabel?.lineBreakMode = .byTruncatingTail
        btn.layer.cornerCurve = .continuous
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    private let statsCard: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 24
        view.layer.cornerCurve = .continuous
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.separator.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let savingsLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Balance"
        lbl.font = .systemFont(ofSize: 14, weight: .medium)
        lbl.textColor = .secondaryLabel
        return lbl
    }()

    private let dolarLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "₾0"
        lbl.font = .systemFont(ofSize: 40, weight: .bold)
        lbl.textColor = .label
        return lbl
    }()

    private let arrowIcon: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "arrow.up.right"))
        iv.tintColor = .systemGreen
        iv.setContentHuggingPriority(.required, for: .horizontal)
        return iv
    }()

    private let amountLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "+₾0"
        lbl.font = .systemFont(ofSize: 12, weight: .medium)
        lbl.textColor = .systemGreen
        return lbl
    }()

    private let periodLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "This Month"
        lbl.font = .systemFont(ofSize: 12)
        lbl.textColor = .secondaryLabel
        return lbl
    }()

    private lazy var trendStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [arrowIcon, amountLabel, periodLabel])
        stack.axis = .horizontal
        stack.spacing = 6
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var statsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [savingsLabel, dolarLabel, trendStack])
        stack.axis = .vertical
        stack.spacing = 6
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let monthlyExpensesView: MonthlyExpensesView = {
        let view = MonthlyExpensesView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let piggyView: PiggyView = {
        let view = PiggyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let manageLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Manage"
        lb.textColor = .secondaryLabel
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .systemFont(ofSize: 14, weight: .semibold)
        return lb
    }()

    private let tableContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .secondarySystemBackground
        v.layer.cornerRadius = 24
        v.layer.cornerCurve = .continuous
        v.layer.masksToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.separator.cgColor
        return v
    }()

    private let tableView: UITableView = {
        let table = UITableView()
        table.layer.cornerRadius = 0
        table.layer.masksToBounds = false
        table.tintColor = .black
        table.isScrollEnabled = true
        table.showsVerticalScrollIndicator = true
        table.register(FinanceCell.self, forCellReuseIdentifier: "FinanceCell")
        table.register(AnalysisCell.self, forCellReuseIdentifier: "AnalysisCell")
        table.register(BonusCell.self, forCellReuseIdentifier: "BonusCell")
        table.register(SettingsCell.self, forCellReuseIdentifier: "SettingsCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .secondarySystemBackground
        table.separatorStyle = .singleLine
        table.estimatedRowHeight = 60
        table.rowHeight = UITableView.automaticDimension
        table.contentInset = UIEdgeInsets(top: 2, left: 0, bottom: 8, right: 0)
        return table
    }()

    private let actionStack = UIStackView()
    private let addMoneyButton = UIButton(type: .system)
    private let transferButton = UIButton(type: .system)

    private var balanceListener: ListenerRegistration?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Space"
        view.backgroundColor = .systemBackground
        setupLayout()
        setupActions()
        tableView.dataSource = self
        tableView.delegate = self
        userHeaderButton.addTarget(self, action: #selector(didTapHeader), for: .touchUpInside)
        startBalanceListener()
        if let name = Auth.auth().currentUser?.displayName, !name.isEmpty {
            userHeaderButton.configuration?.title = name
        }
    }

    deinit {
        balanceListener?.remove()
    }

    private func setupLayout() {
        view.addSubview(userHeaderButton)
        NSLayoutConstraint.activate([
            userHeaderButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            userHeaderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            userHeaderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        view.addSubview(statsCard)
        statsCard.addSubview(statsStack)
        NSLayoutConstraint.activate([
            statsCard.topAnchor.constraint(equalTo: userHeaderButton.bottomAnchor, constant: 16),
            statsCard.leadingAnchor.constraint(equalTo: userHeaderButton.leadingAnchor),
            statsCard.trailingAnchor.constraint(equalTo: userHeaderButton.trailingAnchor),

            statsStack.topAnchor.constraint(equalTo: statsCard.topAnchor, constant: 20),
            statsStack.leadingAnchor.constraint(equalTo: statsCard.leadingAnchor, constant: 20),
            statsStack.trailingAnchor.constraint(lessThanOrEqualTo: statsCard.trailingAnchor, constant: -20),
            statsStack.bottomAnchor.constraint(equalTo: statsCard.bottomAnchor, constant: -20)
        ])

        view.addSubview(monthlyExpensesView)
        view.addSubview(piggyView)
        NSLayoutConstraint.activate([
            monthlyExpensesView.topAnchor.constraint(equalTo: statsCard.bottomAnchor, constant: 16),
            monthlyExpensesView.leadingAnchor.constraint(equalTo: statsCard.leadingAnchor),
            monthlyExpensesView.heightAnchor.constraint(equalToConstant: 160),

            piggyView.topAnchor.constraint(equalTo: monthlyExpensesView.topAnchor),
            piggyView.trailingAnchor.constraint(equalTo: statsCard.trailingAnchor),
            piggyView.heightAnchor.constraint(equalTo: monthlyExpensesView.heightAnchor),

            monthlyExpensesView.trailingAnchor.constraint(equalTo: piggyView.leadingAnchor, constant: -12),
            monthlyExpensesView.widthAnchor.constraint(equalTo: piggyView.widthAnchor)
        ])

        actionStack.axis = .horizontal
        actionStack.spacing = 12
        actionStack.alignment = .fill
        actionStack.distribution = .fillEqually
        actionStack.translatesAutoresizingMaskIntoConstraints = false

        styleActionButton(addMoneyButton, title: "Add Money", icon: "plus.circle.fill")
        styleActionButton(transferButton, title: "Transfer", icon: "arrow.right.arrow.left.circle.fill")

        actionStack.addArrangedSubview(addMoneyButton)
        actionStack.addArrangedSubview(transferButton)

        view.addSubview(actionStack)
        NSLayoutConstraint.activate([
            actionStack.topAnchor.constraint(equalTo: monthlyExpensesView.bottomAnchor, constant: 12),
            actionStack.leadingAnchor.constraint(equalTo: statsCard.leadingAnchor),
            actionStack.trailingAnchor.constraint(equalTo: statsCard.trailingAnchor),
            actionStack.heightAnchor.constraint(equalToConstant: 56)
        ])

        view.addSubview(manageLabel)
        NSLayoutConstraint.activate([
            manageLabel.topAnchor.constraint(equalTo: actionStack.bottomAnchor, constant: 16),
            manageLabel.leadingAnchor.constraint(equalTo: statsCard.leadingAnchor),
            manageLabel.trailingAnchor.constraint(lessThanOrEqualTo: statsCard.trailingAnchor)
        ])

        view.addSubview(tableContainerView)
        tableContainerView.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableContainerView.topAnchor.constraint(equalTo: manageLabel.bottomAnchor, constant: 8),
            tableContainerView.leadingAnchor.constraint(equalTo: statsCard.leadingAnchor),
            tableContainerView.trailingAnchor.constraint(equalTo: statsCard.trailingAnchor),
            tableContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),

            tableView.topAnchor.constraint(equalTo: tableContainerView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: tableContainerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: tableContainerView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: tableContainerView.bottomAnchor)
        ])
    }

    private func styleActionButton(_ button: UIButton, title: String, icon: String) {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.image = UIImage(systemName: icon)
        config.imagePadding = 8
        config.imagePlacement = .leading
        config.baseBackgroundColor = .black
        config.baseForegroundColor = .white
        config.background.cornerRadius = 14
        button.configuration = config
        button.layer.cornerCurve = .continuous
        button.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupActions() {
        addMoneyButton.addTarget(self, action: #selector(openAddMoney), for: .touchUpInside)
        transferButton.addTarget(self, action: #selector(openTransfer), for: .touchUpInside)
    }

    private func startBalanceListener() {
        balanceListener = AuthService.shared.addBalanceListener { [weak self] newBalance in
            DispatchQueue.main.async {
                self?.dolarLabel.text = "₾\(newBalance)"
            }
        }
    }

    @objc private func openAddMoney() {
        let vc = AddMoneyVC()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func openTransfer() {
        let vc = TranferMoneyVC()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func didTapHeader() {
        let vc = ProfileVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SpaceVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 4 }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FinanceCell", for: indexPath) as! FinanceCell
            cell.accessoryType = .disclosureIndicator
            cell.backgroundColor = .secondarySystemBackground
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnalysisCell", for: indexPath) as! AnalysisCell
            cell.accessoryType = .disclosureIndicator
            cell.backgroundColor = .secondarySystemBackground
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BonusCell", for: indexPath) as! BonusCell
            cell.accessoryType = .disclosureIndicator
            cell.backgroundColor = .secondarySystemBackground
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
            cell.accessoryType = .disclosureIndicator
            cell.backgroundColor = .secondarySystemBackground
            return cell
        default:
            return UITableViewCell()
        }
    }
}
