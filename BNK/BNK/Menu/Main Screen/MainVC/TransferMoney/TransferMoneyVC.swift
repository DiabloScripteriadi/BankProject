//
//  TranferMoneyVC.swift
//  BNK
//
//  Created by chasemedkcorto on 12.03.26.
//


import UIKit
import Contacts
import ContactsUI

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
        lb.text = "Enter your Personal number here."
        lb.textColor = .gray
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .systemFont(ofSize: 15, weight: .medium)
        lb.numberOfLines = 0
        return lb
    }()
  
    private let contactLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Contacts."
        lb.textColor = .gray
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .systemFont(ofSize: 16, weight: .bold)
        lb.numberOfLines = 0
        return lb
    }()
    
    private let searchBar: UISearchBar = {
        let br = UISearchBar()
        br.placeholder = "Who Are You Looking For?"
        br.searchBarStyle = .minimal
        br.translatesAutoresizingMaskIntoConstraints = false
        return br
    }()
    
    private let button: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Continiu", for: .normal)
        btn.tintColor = .label
        btn.setTitleColor(.label, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 11, weight: .semibold)
        btn.titleLabel?.numberOfLines = 2
        btn.titleLabel?.textAlignment = .center
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .secondarySystemBackground
        btn.layer.cornerRadius = 20
        btn.clipsToBounds = true
        btn.titleLabel?.lineBreakMode = .byTruncatingMiddle
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
  
    private let getStartedButton = UIButton(type: .system)
    private var tableViewHeightConstraint: NSLayoutConstraint?
    
    private let personalNumberField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Personal Number"
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        searchBar.delegate = self
        requestContactsAccessAndFetch()
        setupGetStartedButton()
        self.title = "თანხის გადარიცხვა"
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
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(personalNumberField)
        contentView.addSubview(button)
        contentView.addSubview(contactLabel)
        contentView.addSubview(searchBar)
        contentView.addSubview(contactsTableView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            personalNumberField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            personalNumberField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            personalNumberField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            personalNumberField.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            button.topAnchor.constraint(equalTo: personalNumberField.bottomAnchor, constant: 16),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(greaterThanOrEqualToConstant: 140)
        ])
        
        NSLayoutConstraint.activate([
            contactLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contactLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
            contactLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: contactLabel.bottomAnchor, constant: 16),
            searchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            searchBar.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        tableViewHeightConstraint = contactsTableView.heightAnchor.constraint(equalToConstant: 80)
        tableViewHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            contactsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 12),
            contactsTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            contactsTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            contactsTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
    
    private func setupGetStartedButton() {
        getStartedButton.translatesAutoresizingMaskIntoConstraints = false
        getStartedButton.setTitle("Get Started", for: .normal)
        getStartedButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        getStartedButton.setTitleColor(.white, for: .normal)
        getStartedButton.backgroundColor = .systemGray4
        getStartedButton.layer.cornerRadius = 14
        getStartedButton.isEnabled = false
//        getStartedButton.addTarget(self, action: #selector(getStartedTapped), for: .touchUpInside)
        view.addSubview(getStartedButton)

        NSLayoutConstraint.activate([
            getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getStartedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            getStartedButton.widthAnchor.constraint(equalToConstant: 300),
            getStartedButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func requestContactsAccessAndFetch() {
        contactStore.requestAccess(for: .contacts) { [weak self] granted, error in
            guard let self = self else { return }
            if let error = error {
                print("Contacts access error: \(error.localizedDescription)")
                return
            }
            if granted {
                self.fetchContacts()
            } else {
                print("Contacts access denied")
            }
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
                guard let firstNumber = contact.phoneNumbers.first?.value.stringValue,
                      !firstNumber.isEmpty else { return }
                let model = ContactsStruct(
                    givenName: contact.givenName,
                    familyName: contact.familyName,
                    number: firstNumber
                )
                fetched.append(model)
            }
            DispatchQueue.main.async {
                self.contacts = fetched
                self.contactsTableView.reloadData()
                self.updateTableViewHeight()
            }
        } catch {
            print("\(error)")
        }
    }
}

extension TranferMoneyVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) { }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension TranferMoneyVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsCell") as! ContactsCell
        let model = contacts[indexPath.row]
        let fullName = [model.givenName, model.familyName]
            .joined(separator: " ")
            .trimmingCharacters(in: .whitespaces)
        cell.configure(name: fullName.isEmpty ? "Unknown" : fullName,
                       number: model.number)
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}
#warning("functionebi dasamatebeli ")
