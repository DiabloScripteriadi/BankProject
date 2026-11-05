//
//  PiggyView.swift
//  BNK
//
//  Created by chasemedkcorto on 30.08.26.
//

import Foundation
import UIKit
import SwiftUI

class PiggyView: UIView {
    private let monthlyContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.1)
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    private let piggyLabel: UILabel = {
        let label = UILabel()
        label.text = "Piggy Savings"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        return label
    }()
    private let iconBadgeView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor =  UIColor.systemOrange.withAlphaComponent(0.14)
        v.layer.cornerRadius = 10
        return v
    }()
    
    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular)
        imageView.image = UIImage(systemName: "building.columns.fill")?.applyingSymbolConfiguration(config)
        imageView.tintColor = .systemOrange
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
    
    private let progressView: UIProgressView = {
        let p = UIProgressView(progressViewStyle: .bar)
        p.translatesAutoresizingMaskIntoConstraints = false
        p.trackTintColor = UIColor.systemOrange.withAlphaComponent(0.18)
        p.progressTintColor = .systemOrange
        p.progress = 0.34
        return p
    }()
    
    private let goalLabel: UILabel = {
        let l = UILabel()
        l.text = "34% of $2,000 goal"
        l.font = .systemFont(ofSize: 11)
        l.textColor = .systemGray
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    private func setupView() {
        backgroundColor = .clear
        addSubview(monthlyContainer)
        monthlyContainer.addSubview(iconBadgeView)
        monthlyContainer.addSubview(icon)
        monthlyContainer.addSubview(piggyLabel)
        monthlyContainer.addSubview(amount)
        monthlyContainer.addSubview(progressView)
        monthlyContainer.addSubview(goalLabel)
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
            piggyLabel.topAnchor.constraint(equalTo: monthlyContainer.topAnchor, constant: 9),
            piggyLabel.bottomAnchor.constraint(equalTo: icon.bottomAnchor, constant: 78),
            piggyLabel.leadingAnchor.constraint(equalTo: iconBadgeView.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            amount.topAnchor.constraint(equalTo: piggyLabel.bottomAnchor, constant: -45),
            amount.leadingAnchor.constraint(equalTo: piggyLabel.leadingAnchor),
            amount.trailingAnchor.constraint(lessThanOrEqualTo: monthlyContainer.trailingAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: monthlyContainer.leadingAnchor, constant: 16),
            progressView.trailingAnchor.constraint(equalTo: monthlyContainer.trailingAnchor, constant: -16),
            progressView.bottomAnchor.constraint(equalTo: monthlyContainer.bottomAnchor, constant: -25)
        ])
        
        NSLayoutConstraint.activate([
            goalLabel.leadingAnchor.constraint(equalTo: progressView.leadingAnchor),
            goalLabel.trailingAnchor.constraint(lessThanOrEqualTo: monthlyContainer.trailingAnchor, constant: -16),
            goalLabel.bottomAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 20)
        ])
    }
}

