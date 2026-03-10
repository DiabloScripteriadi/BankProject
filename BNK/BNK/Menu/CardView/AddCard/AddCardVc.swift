//
//  AddCardVc.swift
//  BNK
//
//  Created by chasemedkcorto on 02.03.26.
//

import UIKit
import CreditCardFormatter
protocol ButtonDelegate {
    func didTapButton(with view: Card)
}
class AddCardVc: UIViewController, UITextFieldDelegate {
    var delegate: ButtonDelegate?
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Add New Card"
        lb.textColor = .label
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
        view.backgroundColor = .white
        
        setupScroll()
        setupUI()
        setupFields()
        setupActions()
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
    
    private static func makeTextField(_ placeholder: String) -> UITextField {
        let tx = UITextField()
        tx.translatesAutoresizingMaskIntoConstraints = false
        tx.placeholder = placeholder
        tx.textAlignment = .center
        tx.backgroundColor = .systemGray5
        tx.layer.cornerRadius = 24
        return tx
    }
    
    private func setupFields() {
        cardNumberTextField.keyboardType = .numberPad
        expiryDateTextField.keyboardType = .numberPad
        cvvTextField.keyboardType = .numberPad
        cvvTextField.isSecureTextEntry = true
        
        cardHolderNameTextField.autocapitalizationType = .words
        
        cardNumberTextField.delegate = self
        expiryDateTextField.delegate = self
        cvvTextField.delegate = self
    }
    
    private func setupActions() {
        cardNumberTextField.addTarget(self, action: #selector(cardNumberChanged), for: .editingChanged)
        expiryDateTextField.addTarget(self, action: #selector(expiryChanged), for: .editingChanged)
        cardHolderNameTextField.addTarget(self, action: #selector(holderChanged), for: .editingChanged)
        addCardBtn.addTarget(self, action: #selector(addCardTapped), for: .touchUpInside)
        addCardBtn.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
    }
    
    
    private let ccFormatter = CreditCardFormatter()
    @objc private func cardNumberChanged() {
        let raw = cardNumberTextField.text ?? ""
        let masked = ccFormatter.formattedString(from: raw)
        if cardNumberTextField.text != masked {
            cardNumberTextField.text = masked
        }
        cardView.updateNumber(masked)
    }
    
    @objc private func expiryChanged() {
        let digits = (expiryDateTextField.text ?? "").filter { $0.isNumber }
        let limited = String(digits.prefix(4))
        var formatted = ""
        for (i, ch) in limited.enumerated() {
            if i == 2 { formatted.append("/") }
            formatted.append(ch)
        }
        if expiryDateTextField.text != formatted {
            expiryDateTextField.text = formatted
        }
        cardView.updateExpiry(formatted)
    }
    
    @objc private func holderChanged() {
        let text = cardHolderNameTextField.text ?? ""
        cardView.updateHolder(text)
    }
    @objc func buttonTap() {
        delegate?.didTapButton(with: cardView)
    }
    @objc private func addCardTapped() {
        let number = (cardNumberTextField.text ?? "").replacingOccurrences(of: " ", with: "")
        let holder = cardHolderNameTextField.text ?? ""
        let expiry = expiryDateTextField.text ?? ""
        let cvv = cvvTextField.text ?? ""
        
        guard !number.isEmpty, !holder.isEmpty, !expiry.isEmpty, !cvv.isEmpty else {
        
            return
        }
        
        AuthService.shared.createCard(cardNumber: number, cardHolder: holder, expireDate: expiry, cvv: cvv) { [weak self] success, error in
            DispatchQueue.main.async {
                if success {
                    self?.dismiss(animated: true, completion: nil)
                } else {
                    print("Create card error: \(error?.localizedDescription ?? "error")")
                }
            }
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == cardNumberTextField || textField == expiryDateTextField || textField == cvvTextField {
            if !string.isEmpty {
                let allowed = CharacterSet.decimalDigits
                if string.rangeOfCharacter(from: allowed.inverted) != nil {
                    return false
                }
            }
        }
        
        if textField == cvvTextField {
            let current = textField.text ?? ""
            guard let r = Range(range, in: current) else { return false }
            let updated = current.replacingCharacters(in: r, with: string)
           
            return updated.count <= 3
        }
        
        return true
    }
}
