//
//  AddCardVc.swift
//  BNK
//
//  Created by chasemedkcorto on 02.03.26.
//

import UIKit
import CreditCardFormatter
class AddCardVc: UIViewController, {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Add New Card"
        lb.textColor = .black
        lb.font = .systemFont(ofSize: 20, weight: .heavy)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let cardView = Card()
    
    private let cardNumberTextField = AddCardVc.makeTextField("Card Number")
    private let cardHolderNameTextField = AddCardVc.makeTextField("Card Holder Name")
    private let expiryDateTextField = AddCardVc.makeTextField("MM/YY")
    private let cvvTextField = AddCardVc.makeTextField("CVV")
    
    private let addCardBtn: UIButton = {
        let bt = UIButton(type: .system)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("Add Card", for: .normal)
        bt.setTitleColor(.black, for: .normal)
        bt.backgroundColor = .systemYellow
        bt.layer.cornerRadius = 16
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupScroll()
        setupUI()
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
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupUI() {
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(cardView)
        contentView.addSubview(cardNumberTextField)
        contentView.addSubview(cardHolderNameTextField)
        contentView.addSubview(expiryDateTextField)
        contentView.addSubview(cvvTextField)
        contentView.addSubview(addCardBtn)
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cvvTextField.delegate = self
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            cardView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            cardView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cardView.widthAnchor.constraint(equalToConstant: 300),
            cardView.heightAnchor.constraint(equalToConstant: 200),
            
            cardNumberTextField.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 20),
            cardNumberTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cardNumberTextField.widthAnchor.constraint(equalToConstant: 300),
            cardNumberTextField.heightAnchor.constraint(equalToConstant: 50),
            
            cardHolderNameTextField.topAnchor.constraint(equalTo: cardNumberTextField.bottomAnchor, constant: 12),
            cardHolderNameTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cardHolderNameTextField.widthAnchor.constraint(equalToConstant: 300),
            cardHolderNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            expiryDateTextField.topAnchor.constraint(equalTo: cardHolderNameTextField.bottomAnchor, constant: 12),
            expiryDateTextField.leadingAnchor.constraint(equalTo: cardHolderNameTextField.leadingAnchor),
            expiryDateTextField.widthAnchor.constraint(equalToConstant: 140),
            expiryDateTextField.heightAnchor.constraint(equalToConstant: 50),
            
            cvvTextField.topAnchor.constraint(equalTo: cardHolderNameTextField.bottomAnchor, constant: 12),
            cvvTextField.trailingAnchor.constraint(equalTo: cardHolderNameTextField.trailingAnchor),
            cvvTextField.widthAnchor.constraint(equalToConstant: 140),
            cvvTextField.heightAnchor.constraint(equalToConstant: 50),
            
            addCardBtn.topAnchor.constraint(equalTo: expiryDateTextField.bottomAnchor, constant: 20),
            addCardBtn.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            addCardBtn.widthAnchor.constraint(equalToConstant: 220),
            addCardBtn.heightAnchor.constraint(equalToConstant: 50),
            
          
            addCardBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
    //stackview pontia
    private static func makeTextField(_ placeholder: String) -> UITextField {
        let tx = UITextField()
        tx.translatesAutoresizingMaskIntoConstraints = false
        tx.placeholder = placeholder
        tx.textAlignment = .center
        tx.backgroundColor = .systemGray5
        tx.layer.cornerRadius = 24
        return tx
    }
}
extension AddCardVc: UITextFieldDelegate {
    
}
