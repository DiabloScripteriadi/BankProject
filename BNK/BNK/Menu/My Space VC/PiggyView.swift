import Foundation
import UIKit
import SwiftUI

class PiggyView: UIView {

    private let monthlyContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()

    private let monthlyLabel: UILabel = {
        let label = UILabel()
        label.text = "𝕄𝕠𝕟𝕥𝕙𝕝𝕪 𝔼𝕩𝕡𝕖𝕟𝕤𝕖𝕤"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return label
    }()

    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular)
        imageView.image = UIImage(systemName: "arrow.down.circle")?.applyingSymbolConfiguration(config)
        imageView.tintColor = .white
        return imageView
    }()

    private let amount: UILabel = {
        let label = UILabel()
        label.text = "1200$"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
    }

    private func setupView() {
        backgroundColor = .clear
        addSubview(monthlyContainer)

        monthlyContainer.addSubview(icon)
        monthlyContainer.addSubview(monthlyLabel)
        monthlyContainer.addSubview(amount)
    }

    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            monthlyContainer.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            monthlyContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            monthlyContainer.widthAnchor.constraint(equalToConstant: 190),
            monthlyContainer.heightAnchor.constraint(equalToConstant: 75),
            monthlyContainer.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: monthlyContainer.topAnchor, constant: 6),
            icon.leadingAnchor.constraint(equalTo: monthlyContainer.leadingAnchor, constant: 12),
            icon.widthAnchor.constraint(equalToConstant: 18),
            icon.heightAnchor.constraint(equalToConstant: 24)
        ])

        NSLayoutConstraint.activate([
            monthlyLabel.topAnchor.constraint(equalTo: monthlyContainer.topAnchor, constant: 9),
            monthlyLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8),
            monthlyLabel.trailingAnchor.constraint(lessThanOrEqualTo: monthlyContainer.trailingAnchor, constant: -12)
        ])

        NSLayoutConstraint.activate([
            amount.topAnchor.constraint(equalTo: monthlyLabel.bottomAnchor, constant: 6),
            amount.leadingAnchor.constraint(equalTo: monthlyLabel.leadingAnchor,constant: -24),
            amount.trailingAnchor.constraint(lessThanOrEqualTo: monthlyContainer.trailingAnchor, constant:
                                            -12),
            amount.bottomAnchor.constraint(lessThanOrEqualTo: monthlyContainer.bottomAnchor, constant: -10)
        ])
    }
}

#Preview {
   MonthlyExpensesView()
}
