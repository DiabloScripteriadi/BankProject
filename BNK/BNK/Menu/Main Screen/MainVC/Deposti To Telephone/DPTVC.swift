//
//  DPTVC.swift
//  BNK
//
//  Created by chasemedkcorto on 12.02.26.
//
import UIKit
import Contacts
import ContactsUI

class DPTVC: UIViewController {
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
        lb.text = "Enter your phone number here."
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
    
    private let mobileBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Mobile Number\n555 555 5555", for: .normal)
        btn.setImage(UIImage(systemName: "iphone"), for: .normal)
        btn.tintColor = .label
        btn.setTitleColor(.label, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 11, weight: .semibold)
        btn.titleLabel?.numberOfLines = 2
        btn.titleLabel?.textAlignment = .center
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        btn.backgroundColor = .secondarySystemBackground
        btn.layer.cornerRadius = 20
        btn.clipsToBounds = true
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 4)
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
    private let stackView = UIStackView()
    private var otpFields: [UITextField] = []
    
    private var tableViewHeightConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupOTPFields()
        requestContactsAccessAndFetch()
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
    
    private func setupOTPFields() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        for index in 0..<6 {
            let tf = UITextField()
            tf.keyboardType = .numberPad
            tf.textAlignment = .center
            tf.font = .systemFont(ofSize: 20, weight: .semibold)
            tf.layer.borderWidth = 1
            tf.layer.borderColor = UIColor.systemGray3.cgColor
            tf.layer.cornerRadius = 12
            tf.delegate = self
            tf.tag = index
            tf.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
            
            stackView.addArrangedSubview(tf)
            otpFields.append(tf)
        }
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(searchBar)
        contentView.addSubview(contactLabel)
        contentView.addSubview(mobileBtn)
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
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            mobileBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mobileBtn.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            mobileBtn.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            contactLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            contactLabel.topAnchor.constraint(equalTo: mobileBtn.bottomAnchor, constant: 20),
            
            searchBar.topAnchor.constraint(equalTo: contactLabel.bottomAnchor, constant: 16),
            searchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        tableViewHeightConstraint = contactsTableView.heightAnchor.constraint(equalToConstant: 80)
        tableViewHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            contactsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 12),
            contactsTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contactsTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contactsTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
    
    @objc private func textDidChange(_ textField: UITextField) {
        if let text = textField.text, text.count == 1 {
            let nextTag = textField.tag + 1
            if nextTag < otpFields.count {
                otpFields[nextTag].becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
        }
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
                    number: firstNumber,
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

extension DPTVC: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if string.isEmpty {
            textField.text = ""
            let prevTag = textField.tag - 1
            if prevTag >= 0 { otpFields[prevTag].becomeFirstResponder() }
            return false
        }
        return textField.text?.isEmpty ?? true
    }
}
extension DPTVC: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
    }
}
extension DPTVC: UITableViewDelegate, UITableViewDataSource {
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

extension DPTVC: CNContactPickerDelegate { }

#warning("gasaketebelia cellshi davaregulitor Miranda da numberLabel")

