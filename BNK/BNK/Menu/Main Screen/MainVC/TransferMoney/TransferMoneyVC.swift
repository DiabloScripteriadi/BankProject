//
//  TranferMoneyVC.swift
//  BNK
//
//  Created by chasemedkcorto on 12.03.26.
//
import UIKit
import Contacts
import ContactsUI
import FirebaseAuth

class TranferMoneyVC: UIViewController {
    private let scrollView: UIScrollView = {
        let sl = UIScrollView()
        sl.translatesAutoresizingMaskIntoConstraints = false
        sl.isScrollEnabled = true
        sl.showsVerticalScrollIndicator = true
        return sl
    }()
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Enter Receiver Phone or Select Contact"
        lb.textColor = .secondaryLabel
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .systemFont(ofSize: 15, weight: .medium)
        lb.numberOfLines = 0
        return lb
    }()
    private let contactLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Contacts"
        lb.textColor = .label
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .systemFont(ofSize: 16, weight: .bold)
        lb.numberOfLines = 1
        return lb
    }()
    private let searchBar: UISearchBar = {
        let br = UISearchBar()
        br.placeholder = "Who Are You Looking For?"
        br.searchBarStyle = .minimal
        br.translatesAutoresizingMaskIntoConstraints = false
        return br
    }()
    private let amountContainer = UIView()
    private let amountField: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .decimalPad
        tf.textAlignment = .center
        tf.font = .systemFont(ofSize: 24, weight: .semibold)
        tf.placeholder = "Amount"
        tf.textColor = .label
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    private let personalNumberField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Receiver Phone (+9955...)"
        textField.keyboardType = .phonePad
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        return textField
    }()
    private let continueButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Continue", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        btn.backgroundColor = .systemGray4
        btn.layer.cornerRadius = 14
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isEnabled = false
        return btn
    }()
    private lazy var contactsTableView: UITableView = {
        let tb = UITableView()
        tb.dataSource = self
        tb.delegate = self
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.estimatedRowHeight = 80
        tb.rowHeight = UITableView.automaticDimension
        tb.backgroundColor = .systemBackground
        tb.register(ContactsCell.self, forCellReuseIdentifier: "ContactsCell")
        tb.separatorStyle = .none
        return tb
    }()
    private var contactStore = CNContactStore()
    private var contacts = [ContactsStruct]()
    private var tableViewHeightConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = "Transfer Money"
        setupUI()
        searchBar.delegate = self
        requestContactsAccessAndFetch()
        amountField.addTarget(self, action: #selector(inputsChanged), for: .editingChanged)
        personalNumberField.addTarget(self, action: #selector(inputsChanged), for: .editingChanged)
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        setupKeyboardToolbar()
        setupTapToDismiss()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateTableViewHeight()
    }

    private func updateTableViewHeight() {
        contactsTableView.layoutIfNeeded()
        let height = contactsTableView.contentSize.height
        tableViewHeightConstraint?.constant = height
    }

    private func setupUI() {
        amountContainer.translatesAutoresizingMaskIntoConstraints = false
        amountContainer.layer.cornerRadius = 12
        amountContainer.layer.borderWidth = 1
        amountContainer.layer.borderColor = UIColor.systemGray4.cgColor
        amountContainer.backgroundColor = .secondarySystemBackground

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(personalNumberField)
        contentView.addSubview(amountContainer)
        amountContainer.addSubview(amountField)
        contentView.addSubview(contactLabel)
        contentView.addSubview(searchBar)
        contentView.addSubview(contactsTableView)
        view.addSubview(continueButton)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            personalNumberField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            personalNumberField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            personalNumberField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            personalNumberField.heightAnchor.constraint(equalToConstant: 48),

            amountContainer.topAnchor.constraint(equalTo: personalNumberField.bottomAnchor, constant: 12),
            amountContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            amountContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            amountContainer.heightAnchor.constraint(equalToConstant: 56),

            amountField.leadingAnchor.constraint(equalTo: amountContainer.leadingAnchor, constant: 12),
            amountField.trailingAnchor.constraint(equalTo: amountContainer.trailingAnchor, constant: -12),
            amountField.centerYAnchor.constraint(equalTo: amountContainer.centerYAnchor),

            contactLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contactLabel.topAnchor.constraint(equalTo: amountContainer.bottomAnchor, constant: 20),
            contactLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),

            searchBar.topAnchor.constraint(equalTo: contactLabel.bottomAnchor, constant: 12),
            searchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            searchBar.heightAnchor.constraint(equalToConstant: 44),

            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            continueButton.widthAnchor.constraint(equalToConstant: 300),
            continueButton.heightAnchor.constraint(equalToConstant: 60)
        ])

        tableViewHeightConstraint = contactsTableView.heightAnchor.constraint(equalToConstant: 80)
        tableViewHeightConstraint?.isActive = true

        NSLayoutConstraint.activate([
            contactsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 12),
            contactsTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contactsTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contactsTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100)
        ])
    }

    @objc private func inputsChanged() {
        let amount = parsedAmount()
        let hasReceiver = !(personalNumberField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        let enabled = amount > 0 && hasReceiver
        continueButton.isEnabled = enabled
        continueButton.backgroundColor = enabled ? .black : .systemGray4
    }

    private func parsedAmount() -> Double {
        let raw = amountField.text?.replacingOccurrences(of: ",", with: ".") ?? ""
        return Double(raw) ?? 0
    }

    @objc private func continueTapped() {
        let amount = parsedAmount()
        let delta = Int(amount.rounded())
        guard delta > 0 else { return }
        guard let senderId = Auth.auth().currentUser?.uid else { return }
        let receiverPhone = (personalNumberField.text ?? "").replacingOccurrences(of: " ", with: "")
        guard !receiverPhone.isEmpty else { return }

        AuthService.shared.updateBalance(delta: -delta) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showBasicAlert(on: self, title: "Error", message: error.localizedDescription)
                return
            }
            AuthService.shared.addTransaction(senderId: senderId, receiverId: receiverPhone, amount: Double(delta)) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        AlertManager.showBasicAlert(on: self, title: "Success", message: "Sent ₾\(delta) to \(receiverPhone)")
                        self.navigationController?.popViewController(animated: true)
                    case .failure(let err):
                        AlertManager.showBasicAlert(on: self, title: "Error", message: err.localizedDescription)
                    }
                }
            }
        }
    }

    private func requestContactsAccessAndFetch() {
        contactStore.requestAccess(for: .contacts) { [weak self] granted, error in
            guard let self = self else { return }
            if let _ = error { return }
            if granted { self.fetchContacts() }
        }
    }

    private func fetchContacts() {
        let keys: [CNKeyDescriptor] = [
            CNContactGivenNameKey as CNKeyDescriptor,
            CNContactFamilyNameKey as CNKeyDescriptor,
            CNContactPhoneNumbersKey as CNKeyDescriptor
        ]
        let request = CNContactFetchRequest(keysToFetch: keys)
        request.sortOrder = .userDefault
        var fetched: [ContactsStruct] = []
        do {
            try contactStore.enumerateContacts(with: request) { contact, _ in
                guard let firstNumber = contact.phoneNumbers.first?.value.stringValue, !firstNumber.isEmpty else { return }
                let model = ContactsStruct(givenName: contact.givenName, familyName: contact.familyName, number: firstNumber)
                fetched.append(model)
            }
            DispatchQueue.main.async {
                self.contacts = fetched
                self.contactsTableView.reloadData()
                self.updateTableViewHeight()
            }
        } catch { }
    }

    private func setupKeyboardToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
        toolbar.items = [flex, done]
        amountField.inputAccessoryView = toolbar
        personalNumberField.inputAccessoryView = toolbar
    }

    private func setupTapToDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func doneTapped() { view.endEditing(true) }
    @objc private func handleBackgroundTap() { view.endEditing(true) }
}

extension TranferMoneyVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) { }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { searchBar.resignFirstResponder() }
}

extension TranferMoneyVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { contacts.count }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsCell") as! ContactsCell
        let model = contacts[indexPath.row]
        let fullName = [model.givenName, model.familyName].joined(separator: " ").trimmingCharacters(in: .whitespaces)
        cell.configure(name: fullName.isEmpty ? "Unknown" : fullName, number: model.number)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 50 }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = contacts[indexPath.row]
        let clean = model.number.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")
        personalNumberField.text = clean
        inputsChanged()
    }
}
