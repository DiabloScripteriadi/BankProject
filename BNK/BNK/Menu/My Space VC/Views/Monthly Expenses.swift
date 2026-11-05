//
//  Monthly Expenses.swift
//  BNK
//
//  Created by chasemedkcorto on 30.08.26.
//

import Foundation
import UIKit
import SwiftUI

class MonthlyExpensesView: UIView {

    private let monthlyContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 234/255, green: 241/255, blue: 255/255, alpha: 1)
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()

    private let monthlyLabel: UILabel = {
        let label = UILabel()
        label.text = "Monthly Expenses"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        return label
    }()
    private let iconBadgeView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 0.14)
        v.layer.cornerRadius = 10
        return v
    }()

    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular)
        imageView.image = UIImage(systemName: "chart.bar.fill")?.applyingSymbolConfiguration(config)
        imageView.tintColor = .blue
        return imageView
    }()

    private let amount: UILabel = {
        let label = UILabel()
        label.text = "$35000"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private let arrowiconView : UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .systemGreen
        icon.accessibilityLabel = "arrow"
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = UIImage(systemName: "arrow.up.right")
        return icon
    }()
    
    private let percentLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "+8% than last month"
        lbl.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        lbl.textColor = .systemGreen
        lbl.numberOfLines = 1
        return lbl
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

        monthlyContainer.addSubview(iconBadgeView)
        monthlyContainer.addSubview(icon)
        monthlyContainer.addSubview(monthlyLabel)
        monthlyContainer.addSubview(amount)
        monthlyContainer.addSubview(arrowiconView)
        monthlyContainer.addSubview(percentLabel)
    }

    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            monthlyContainer.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            monthlyContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            monthlyContainer.widthAnchor.constraint(equalToConstant: 160),
            monthlyContainer.heightAnchor.constraint(equalToConstant: 135),
            monthlyContainer.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            iconBadgeView.topAnchor.constraint(equalTo: monthlyContainer.topAnchor, constant: 12),
            iconBadgeView.leadingAnchor.constraint(equalTo: monthlyContainer.leadingAnchor, constant: 17),
            iconBadgeView.widthAnchor.constraint(equalToConstant: 32),
            iconBadgeView.heightAnchor.constraint(equalToConstant: 32)
        ])

        NSLayoutConstraint.activate([
            icon.centerXAnchor.constraint(equalTo: iconBadgeView.centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: iconBadgeView.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 18),
            icon.heightAnchor.constraint(equalToConstant: 24)
        ])

        NSLayoutConstraint.activate([
            monthlyLabel.topAnchor.constraint(equalTo: monthlyContainer.topAnchor, constant: 9),
            monthlyLabel.bottomAnchor.constraint(equalTo: icon.bottomAnchor, constant: 78),
            monthlyLabel.leadingAnchor.constraint(equalTo: iconBadgeView.leadingAnchor)
        ])

        NSLayoutConstraint.activate([
            amount.topAnchor.constraint(equalTo: monthlyLabel.bottomAnchor, constant: -45),
            amount.leadingAnchor.constraint(equalTo: monthlyLabel.leadingAnchor),
            amount.trailingAnchor.constraint(lessThanOrEqualTo: monthlyContainer.trailingAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            arrowiconView.topAnchor.constraint(equalTo: amount.bottomAnchor, constant: 6),
            arrowiconView.leadingAnchor.constraint(equalTo: amount.leadingAnchor),
            arrowiconView.widthAnchor.constraint(equalToConstant: 12),
            arrowiconView.heightAnchor.constraint(equalToConstant: 12),
            
            percentLabel.centerYAnchor.constraint(equalTo: arrowiconView.centerYAnchor),
            percentLabel.leadingAnchor.constraint(equalTo: arrowiconView.trailingAnchor, constant: 4),
            percentLabel.trailingAnchor.constraint(lessThanOrEqualTo: monthlyContainer.trailingAnchor, constant: -12)
        ])
    }
}
