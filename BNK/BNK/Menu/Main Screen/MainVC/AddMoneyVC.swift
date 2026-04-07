//
//  AddMoneyVC.swift
//  BNK
//
//  Created by chasemedkcorto on 12.03.26.
//

import UIKit

final class AddMoneyVC: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Add Money"
        lb.font = .systemFont(ofSize: 28, weight: .bold)
        lb.textColor = .label
        lb.numberOfLines = 0
        return lb
    }()
    
    private let subtitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Enter an amount and choose a funding method."
        lb.font = .systemFont(ofSize: 15, weight: .medium)
        lb.textColor = .secondaryLabel
        lb.numberOfLines = 0
        return lb
    }()
    
    private let amountContainer = UIView()
    private let amountField: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .decimalPad
        tf.textAlignment = .center
        tf.font = .systemFont(ofSize: 28, weight: .semibold)
        tf.placeholder = "0.00"
        tf.textColor = .label
        return tf
    }()
    
    private let methodControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Card", "Bank", "Apple Pay"])
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    private let continueButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("Continue", for: .normal)
        bt.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        bt.setTitleColor(.white, for: .normal)
        bt.backgroundColor = .systemGray4
        bt.layer.cornerRadius = 14
        bt.isEnabled = false
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Add Money"
        
        setupScroll()
        setupUI()
        amountField.addTarget(self, action: #selector(amountChanged), for: .editingChanged)
        continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        
        setupKeyboardToolbar()
        setupTapToDismiss()
    }
    
    private func setupScroll() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }
    
    private func setupUI() {
        amountContainer.translatesAutoresizingMaskIntoConstraints = false
        amountContainer.layer.cornerRadius = 12
        amountContainer.layer.borderWidth = 1
        amountContainer.layer.borderColor = UIColor.systemGray4.cgColor
        amountContainer.backgroundColor = .secondarySystemBackground
        
        amountField.translatesAutoresizingMaskIntoConstraints = false
        methodControl.translatesAutoresizingMaskIntoConstraints = false
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(amountContainer)
        amountContainer.addSubview(amountField)
        contentView.addSubview(methodControl)
        view.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            amountContainer.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            amountContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            amountContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            amountContainer.heightAnchor.constraint(equalToConstant: 72),
            
            amountField.leadingAnchor.constraint(equalTo: amountContainer.leadingAnchor, constant: 12),
            amountField.trailingAnchor.constraint(equalTo: amountContainer.trailingAnchor, constant: -12),
            amountField.centerYAnchor.constraint(equalTo: amountContainer.centerYAnchor),
            
            methodControl.topAnchor.constraint(equalTo: amountContainer.bottomAnchor, constant: 16),
            methodControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            methodControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            continueButton.widthAnchor.constraint(equalToConstant: 300),
            continueButton.heightAnchor.constraint(equalToConstant: 60),
            
            methodControl.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -100)
        ])
    }
    
    @objc private func amountChanged() {
        let valid = parsedAmount() > 0
        continueButton.isEnabled = valid
        continueButton.backgroundColor = valid ? .black : .systemGray4
    }
    
    private func parsedAmount() -> Double {
        let raw = amountField.text?.replacingOccurrences(of: ",", with: ".") ?? ""
        return Double(raw) ?? 0
    }
    
    @objc private func didTapContinue() {
        let amount = parsedAmount()
        guard amount > 0 else { return }
        // Placeholder for integration with your backend or payment flow.
        let method = methodControl.titleForSegment(at: methodControl.selectedSegmentIndex) ?? "Unknown"
        let message = String(format: "Adding %.2f via %@", amount, method)
        AlertManager.showBasicAlert(on: self, title: "Confirm", message: message)
    }
    
    private func setupKeyboardToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
        toolbar.items = [flex, done]
        amountField.inputAccessoryView = toolbar
    }
    
    private func setupTapToDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func doneTapped() {
        view.endEditing(true)
    }
    
    @objc private func handleBackgroundTap() {
        view.endEditing(true)
    }
}

