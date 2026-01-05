

//
//  Untitled.swift
//  BankProject(BOG)
//
//  Created by chasemedkcorto on 05.01.26.
//
import UIKit
class OnboardingVC:UIViewController {
    private let titleLabel = UILabel()
    private let titleimage = UIImageView()
    private let subtitleImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLabels()
    }
    private func setupLabels(){
        titleLabel.text = "Swift Pay"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
    }
}
