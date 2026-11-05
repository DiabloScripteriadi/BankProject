//
//  AddCardVc.swift
//  BNK
//
//  Created by chasemedkcorto on 02.03.26.
//

import UIKit
import CreditCardFormatter
import FirebaseFirestore
import FirebaseAuth

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
        lb.textColor = .gray
        lb.font = .systemFont(ofSize: 20, weight: .heavy)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let cardView = Card()
    
    private let cardHolderNameTextField = AddCardVc.makeTextField("Enter your full name")
    private let monthlySpendingTextField = AddCardVc.makeTextField("2500$")
    
    private let addCardBtn: UIButton = {
        let bt = UIButton(type: .system)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("Add Card", for: .normal)
        bt.setTitleColor(.black, for: .normal)
        bt.backgroundColor = .systemYellow
        bt.layer.cornerRadius = 16
        return bt
    }()
    
    private let onlinePaymentsBtn: UIButton = {
        let bt = UIButton(type: .system)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("Online Payments", for: .normal)
        bt.setTitleColor(.black, for: .normal)
        bt.backgroundColor = .systemYellow
        bt.layer.cornerRadius = 16
        return bt
    }()
    
    private let virtualCardLabel: UILabel = {
        let lb = UILabel()
        lb.text = "VIRTUAL CARD"
        lb.font = .systemFont(ofSize: 11, weight: .heavy)
        lb.textColor = .gray
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let newCardLbael: UILabel = {
        let lb = UILabel()
        lb.text = "Your new card is ready in seconds."
        lb.font = .systemFont(ofSize: 25, weight: .heavy)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .black
        lb.numberOfLines = 0
        return lb
    }()
    
    private let descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Use it for online shopping and subscriptions. Freeze or delete it whenever you need."
        lb.font = .systemFont(ofSize: 13, weight: .regular)
        lb.textColor = .black
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        return lb
    }()
    
    private let cardHolderLabel: UILabel = {
        let lb = UILabel()
        lb.text = "CARDHOLDER NAME"
        lb.font = .systemFont(ofSize: 11, weight: .heavy)
        lb.textColor = .gray
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let monthlySpendingLimitLabel: UILabel = {
        let lb = UILabel()
        lb.text = "MONTHLY SPENDING LIMIT"
        lb.font = .systemFont(ofSize: 11, weight: .heavy)
        lb.textColor = .gray
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        editButtonItem.title = "Done"
        navigationItem.title = "Create Card"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
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
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }
    
    private func setupUI() {
        contentView.addSubview(virtualCardLabel)
        contentView.addSubview(newCardLbael)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(cardView)
        contentView.addSubview(cardHolderLabel)
        contentView.addSubview(cardHolderNameTextField)
        contentView.addSubview(monthlySpendingTextField)
        contentView.addSubview(monthlySpendingLimitLabel)
        contentView.addSubview(addCardBtn)
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        monthlySpendingTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let side = CGFloat(24)
        
        NSLayoutConstraint.activate([
            virtualCardLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 60),
            virtualCardLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            virtualCardLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -side),
            
            newCardLbael.topAnchor.constraint(equalTo: virtualCardLabel.bottomAnchor, constant: 12),
            newCardLbael.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            newCardLbael.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            
            titleLabel.topAnchor.constraint(equalTo: newCardLbael.bottomAnchor, constant: 13),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -side),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            
            cardView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 35),
            cardView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cardView.widthAnchor.constraint(equalToConstant: 350),
            cardView.heightAnchor.constraint(equalToConstant: 200),
            
            cardHolderLabel.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 40),
            cardHolderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            cardHolderLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -side),
            
            cardHolderNameTextField.topAnchor.constraint(equalTo: cardHolderLabel.bottomAnchor, constant: 8),
            cardHolderNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            cardHolderNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            cardHolderNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            monthlySpendingLimitLabel.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 125),
            monthlySpendingLimitLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            monthlySpendingLimitLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -side),
            
            monthlySpendingTextField.topAnchor.constraint(equalTo: cardHolderNameTextField.bottomAnchor, constant: 35),
            monthlySpendingTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            monthlySpendingTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            monthlySpendingTextField.heightAnchor.constraint(equalToConstant: 50),
            
            addCardBtn.topAnchor.constraint(equalTo: monthlySpendingTextField.bottomAnchor, constant: 20),
            addCardBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            addCardBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            addCardBtn.heightAnchor.constraint(equalToConstant: 50),
            addCardBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
    
    private static func makeTextField(_ placeholder: String) -> UITextField {
        let tx = UITextField()
        tx.translatesAutoresizingMaskIntoConstraints = false
        tx.placeholder = placeholder
        tx.textAlignment = .left
        tx.backgroundColor = .white
        tx.layer.cornerRadius = 22
        tx.layer.masksToBounds = true
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
        tx.leftView = padding
        tx.leftViewMode = .always
        return tx
    }
    
    private func setupFields() {
        cardHolderNameTextField.autocapitalizationType = .words
        cardHolderNameTextField.delegate = self
        cardHolderNameTextField.layer.borderColor = UIColor.black.cgColor
        cardHolderNameTextField.layer.borderWidth = 0.5
        
        monthlySpendingTextField.autocapitalizationType = .words
        monthlySpendingTextField.delegate = self
        monthlySpendingTextField.layer.borderColor = UIColor.black.cgColor
        monthlySpendingTextField.layer.borderWidth = 0.5
    }
    
    private func setupActions() {
        cardHolderNameTextField.addTarget(self, action: #selector(holderChanged), for: .editingChanged)
        monthlySpendingTextField.addTarget(self, action: #selector(holderChanged), for: .editingChanged)
        
        addCardBtn.addTarget(self, action: #selector(addCardTapped), for: .touchUpInside)
        addCardBtn.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
    }
    
    @objc private func doneTapped() {
        view.endEditing(true)
    }
    
    @objc private func handleBackgroundTap() {
        view.endEditing(true)
    }
    
    @objc private func holderChanged() {
        let text = cardHolderNameTextField.text ?? ""
        cardView.updateHolder(text)
    }
    
    @objc func buttonTap() {
        delegate?.didTapButton(with: cardView)
    }
    
    @objc private func addCardTapped() {
        let holder = (cardHolderNameTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        guard !holder.isEmpty else { return }
     
        let number = generateMastercardNumber()
        let cvv = String(format: "%03d", Int.random(in: 0...999))
        let expiry = generateExpiryMMYY(yearsAhead: 3)
        
        let formatter = CreditCardFormatter()
        let masked = formatter.formattedString(from: number)
        cardView.updateNumber(masked)
        cardView.updateExpiry(expiry)
        cardView.updateHolder(holder)
        cardView.updateConstraints()
        let last4 = String(number.suffix(4))
        let brand = "Mastercard"
        let paymentMethodId = UUID().uuidString
        
        print("🔍 ვცდილობ ბარათის შენახვას... Last4: \(last4), UID: \(Auth.auth().currentUser?.uid ?? "NIL")")
        
        AuthService.shared.createCardSecurely(last4: last4, brand: brand, paymentMethodId: paymentMethodId) { [weak self] (success: Bool, error: Error?) in
            DispatchQueue.main.async {
                if success {
                    print("✅ ბარათი წარმატებით აიტვირთა კონტროლერში!")
                    // Notify delegate to inject the card and hide button
                    self?.delegate?.didTapButton(with: self?.cardView ?? Card())
                    // Close the sheet
                    self?.dismiss(animated: true, completion: nil)
                } else {
                    print("❌ ბარათის ატვირთვის ერორი: \(error?.localizedDescription ?? "unknown error")")
                }
            }
        }
    }
    
    // Generator
    private func generateMastercardNumber() -> String {
        let bin = Int.random(in: 51...55)
        var digits: [Int] = [bin / 10, bin % 10]
        for _ in 4..<14 {
            digits.append(Int.random(in: 0...9))
        }
        let check = luhnCheckDigit(for: digits)
        digits.append(check)
        return digits.map(String.init).joined()
    }
    
    private func luhnCheckDigit(for digits: [Int]) -> Int {
        var sum = 0
        for (idx, d) in digits.reversed().enumerated() {
            if idx % 2 == 0 {
                let doubled = d * 2
                sum += (doubled > 9) ? (doubled - 9) : doubled
            } else {
                sum += d
            }
        }
        let mod = sum % 10
        return (10 - mod) % 10
    }
    
    private func generateExpiryMMYY(yearsAhead: Int = 3) -> String {
        let cal = Calendar(identifier: .gregorian)
        let now = Date()
        guard let future = cal.date(byAdding: .year, value: yearsAhead, to: now) else { return "12/30" }
        let comps = cal.dateComponents([.month, .year], from: future)
        let mm = String(format: "%02d", comps.month ?? 12)
        let yy = String(format: "%02d", (comps.year ?? 2030) % 100)
        return "\(mm)/\(yy)"
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}

#Preview{
    AddCardVc()
}

