//
//  PasscodeView.swift
//  BNK
//
//  Created by chasemedkcorto on 09.01.26.
//

import UIKit

 class PasscodeVC: UIViewController {
    
    private let stepLabel = UILabel()
    private let divider = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let stackView = UIStackView()
     
    private var pasTxtFieldStackView = UIStackView()
    private var pasView1 = UIView()
    private var pasView2 = UIView()
    private var pasView3 = UIView()
    private var pasView4 = UIView()
    private var pasView5 = UIView()
    private let getStartedButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupStepLabel()
        setupDivider()
        setupTitleLabel()
        setupStackViewLabels()
        setupPasscodeDots()
        setupGetStartedButton()
    }
    
    
    
    private func setupStepLabel() {
        stepLabel.translatesAutoresizingMaskIntoConstraints = false
        stepLabel.text = "Step 3/5"
        stepLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        stepLabel.textColor = .gray
        view.addSubview(stepLabel)
        
        NSLayoutConstraint.activate([
            stepLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stepLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupDivider() {
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .black
        divider.layer.cornerRadius = 2.5
        view.addSubview(divider)
        
        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: stepLabel.bottomAnchor, constant: 8),
            divider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            divider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            divider.heightAnchor.constraint(equalToConstant: 5)
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "Create Your Passcode"
        titleLabel.font = .systemFont(ofSize: 25, weight: .semibold)
        titleLabel.numberOfLines = 0
        
        subtitleLabel.text = "This Wil be ussed For loggin in"
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.textColor = .gray
        subtitleLabel.numberOfLines = 0
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 35),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
    
    private func setupStackViewLabels() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        view.addSubview(pasTxtFieldStackView)
        pasTxtFieldStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 56),
        ])
        
     
    }
     private func setupPasscodeDots() {
        
         pasTxtFieldStackView.axis = .horizontal
         pasTxtFieldStackView.alignment = .center
         pasTxtFieldStackView.distribution = .equalSpacing
         pasTxtFieldStackView.spacing = 4
         pasTxtFieldStackView.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(pasTxtFieldStackView)
         
  
         let pasViews = [pasView1, pasView2, pasView3, pasView4, pasView5]
         pasViews.forEach { dot in
             dot.backgroundColor = .lightGray
             dot.translatesAutoresizingMaskIntoConstraints = false
             dot.layer.cornerRadius = 5 // half of 10
             dot.clipsToBounds = true
             
             pasTxtFieldStackView.addArrangedSubview(dot)
             
             NSLayoutConstraint.activate([
                 dot.widthAnchor.constraint(equalToConstant: 10),
                 dot.heightAnchor.constraint(equalToConstant: 10)
             ])
         }
     
         NSLayoutConstraint.activate([
             pasTxtFieldStackView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 32),
             pasTxtFieldStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             pasTxtFieldStackView.heightAnchor.constraint(equalToConstant: 16), // small extra padding for dots
             pasTxtFieldStackView.widthAnchor.constraint(equalToConstant: 80) // enough for 5 dots + spacing
         ])
     }


    private func setupGetStartedButton() {
        getStartedButton.translatesAutoresizingMaskIntoConstraints = false
        getStartedButton.setTitle("Verify", for: .normal)
        getStartedButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        getStartedButton.setTitleColor(.white, for: .normal)
        getStartedButton.backgroundColor = .systemGray4
        getStartedButton.layer.cornerRadius = 15
        getStartedButton.isEnabled = false
        
        view.addSubview(getStartedButton)
        
        NSLayoutConstraint.activate([
            getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getStartedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            getStartedButton.widthAnchor.constraint(equalToConstant: 300),
            getStartedButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func updateButtonState() {
        //let isComplete = otpFields.allSatisfy { !($0.text?.isEmpty ?? true) }
      //  getStartedButton.isEnabled = isComplete
        //getStartedButton.backgroundColor = isComplete ? .black : .systemGray4
    }
}
