import UIKit

final class HeroBalanceCard: UIView {

    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Good afternoon 👋"
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .white.withAlphaComponent(0.85)
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Available Balance"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white.withAlphaComponent(0.75)
        return label
    }()

    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textColor = .white
        return label
    }()

    private let cardLabel: UILabel = {
        let label = UILabel()
        label.text = "CARD •••• 4829"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white.withAlphaComponent(0.7)
        return label
    }()

    private let eyeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(
            UIImage(systemName: "eye.fill"),
            for: .normal
        )
        button.tintColor = .white
        return button
    }()

    private let addMoneyButton: UIButton = {
        let button = UIButton(type: .system)

        button.setTitle(" Add Money", for: .normal)
        button.setImage(
            UIImage(systemName: "plus.circle.fill"),
            for: .normal
        )

        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(
            ofSize: 15,
            weight: .bold
        )

        button.backgroundColor = .white
        button.layer.cornerRadius = 22

        return button
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }


    required init?(coder: NSCoder) {
        fatalError()
    }


    private func setup() {

        translatesAutoresizingMaskIntoConstraints = false

        layer.cornerRadius = 30
        clipsToBounds = true


        let gradient = CAGradientLayer()

        gradient.colors = [
            UIColor.systemBlue.cgColor,
            UIColor.systemPurple.cgColor
        ]

        gradient.startPoint = CGPoint(
            x: 0,
            y: 0
        )

        gradient.endPoint = CGPoint(
            x: 1,
            y: 1
        )

        layer.insertSublayer(
            gradient,
            at: 0
        )


        [
            greetingLabel,
            titleLabel,
            balanceLabel,
            cardLabel,
            eyeButton,
            addMoneyButton
        ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }


        NSLayoutConstraint.activate([


            greetingLabel.topAnchor.constraint(
                equalTo: topAnchor,
                constant:24
            ),

            greetingLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant:24
            ),



            titleLabel.topAnchor.constraint(
                equalTo: greetingLabel.bottomAnchor,
                constant:22
            ),

            titleLabel.leadingAnchor.constraint(
                equalTo: greetingLabel.leadingAnchor
            ),



            balanceLabel.topAnchor.constraint(
                equalTo:titleLabel.bottomAnchor,
                constant:4
            ),

            balanceLabel.leadingAnchor.constraint(
                equalTo:greetingLabel.leadingAnchor
            ),



            eyeButton.centerYAnchor.constraint(
                equalTo:balanceLabel.centerYAnchor
            ),

            eyeButton.trailingAnchor.constraint(
                equalTo:trailingAnchor,
                constant:-24
            ),



            cardLabel.leadingAnchor.constraint(
                equalTo:greetingLabel.leadingAnchor
            ),

            cardLabel.bottomAnchor.constraint(
                equalTo:bottomAnchor,
                constant:-24
            ),



            addMoneyButton.trailingAnchor.constraint(
                equalTo:trailingAnchor,
                constant:-20
            ),

            addMoneyButton.bottomAnchor.constraint(
                equalTo:bottomAnchor,
                constant:-16
            ),

            addMoneyButton.heightAnchor.constraint(
                equalToConstant:44
            ),

            addMoneyButton.widthAnchor.constraint(
                equalToConstant:130
            )
        ])
    }


    override func layoutSubviews() {
        super.layoutSubviews()

        if let gradient = layer.sublayers?.first as? CAGradientLayer {
            gradient.frame = bounds
        }
    }
}