//
//  SpaceVC.swift
//  BNK
//
//  Created by chasemedkcorto on 21.08.26.
//

import UIKit
final class SpaceVC: UIViewController {
    private lazy var userHeaderButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "Levani Turmanidze"
        config.image = UIImage(systemName: "person.circle.fill",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 44, weight: .regular))
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
        lbl.text = "Total Savings"
        lbl.font = .systemFont(ofSize: 14, weight: .medium)
        lbl.textColor = .secondaryLabel
        return lbl
    }()

    private let dolarLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "$7,020"
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
        lbl.text = "+$340"
        lbl.font = .systemFont(ofSize: 12, weight: .medium)
        lbl.textColor = .systemGreen
        return lbl
    }()

    private let periodLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "this month"
        lbl.font = .systemFont(ofSize: 12)
        lbl.textColor = .secondaryLabel
        return lbl
    }()

    private lazy var trendStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [arrowIcon, amountLabel, periodLabel])
        stack.axis = .horizontal
        stack.spacing = 4
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

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Space"
        view.backgroundColor = .systemBackground

        setupHeaderButton()
        setupStatsCard()
    }


    private func setupHeaderButton() {
        view.addSubview(userHeaderButton)
        NSLayoutConstraint.activate([
            userHeaderButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            userHeaderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userHeaderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
         
        ])
    }

    private func setupStatsCard() {
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
    }


    @objc private func didTapHeader() {
        let vc = ProfileVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

#Preview {
    SpaceVC()
}
