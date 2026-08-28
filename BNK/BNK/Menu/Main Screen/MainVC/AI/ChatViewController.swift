//
//  ChatViewController.swift
//  BNK
//
//  Created by chasemedkcorto on 09.08.26.
//
import UIKit

final class ChatViewController: UIViewController {

    private let tableView = UITableView()
    private let inputContainer = UIView()
    private let textView = UITextView()
    private let sendButton = UIButton(type: .system)
    private let loadingIndicator = UIActivityIndicatorView(style: .medium)

    private var inputBottomConstraint: NSLayoutConstraint!
    private var textViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "AI ჩატი"
        view.backgroundColor = .systemBackground

        setupTableView()
        setupInputBar()
        registerForKeyboardNotifications()

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tableView.addGestureRecognizer(tap)
    }


    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .interactive
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }

    private func setupInputBar() {
        inputContainer.translatesAutoresizingMaskIntoConstraints = false
        inputContainer.backgroundColor = .systemBackground
        view.addSubview(inputContainer)

        let topLine = UIView()
        topLine.backgroundColor = .separator
        topLine.translatesAutoresizingMaskIntoConstraints = false
        inputContainer.addSubview(topLine)

        textView.font = .systemFont(ofSize: 16)
        textView.layer.cornerRadius = 20
        textView.backgroundColor = .secondarySystemBackground
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.isScrollEnabled = false
        textView.delegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        inputContainer.addSubview(textView)

        sendButton.setImage(UIImage(systemName: "arrow.up.circle.fill"), for: .normal)
//        sendButton.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 30)
        sendButton.tintColor = .systemGray3
        sendButton.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        inputContainer.addSubview(sendButton)

        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.hidesWhenStopped = true
        view.addSubview(loadingIndicator)

        inputBottomConstraint = inputContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        textViewHeightConstraint = textView.heightAnchor.constraint(equalToConstant: 40)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: inputContainer.topAnchor),

            inputContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inputContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            inputBottomConstraint,

            topLine.topAnchor.constraint(equalTo: inputContainer.topAnchor),
            topLine.leadingAnchor.constraint(equalTo: inputContainer.leadingAnchor),
            topLine.trailingAnchor.constraint(equalTo: inputContainer.trailingAnchor),
            topLine.heightAnchor.constraint(equalToConstant: 0.5),

            textView.topAnchor.constraint(equalTo: inputContainer.topAnchor, constant: 8),
            textView.bottomAnchor.constraint(equalTo: inputContainer.bottomAnchor, constant: -8),
            textView.leadingAnchor.constraint(equalTo: inputContainer.leadingAnchor, constant: 12),
            textViewHeightConstraint,

            sendButton.centerYAnchor.constraint(equalTo: textView.centerYAnchor),
            sendButton.leadingAnchor.constraint(equalTo: textView.trailingAnchor, constant: 6),
            sendButton.trailingAnchor.constraint(equalTo: inputContainer.trailingAnchor, constant: -10),
            sendButton.widthAnchor.constraint(equalToConstant: 34),
            sendButton.heightAnchor.constraint(equalToConstant: 34),

            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.bottomAnchor.constraint(equalTo: inputContainer.topAnchor, constant: -8)
        ])
    }


    @objc private func sendTapped() {
        // TODO: აქ მოგვიანებით დაემატება შეტყობინების გაგზავნის/პასუხის ლოგიკა.
        textView.text = ""
        textViewDidChange(textView)
        updateSendButtonState()
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    private func updateSendButtonState() {
        let hasText = !(textView.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        sendButton.tintColor = hasText ? .systemBlue : .systemGray3
        sendButton.isEnabled = hasText
    }


    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @objc private func keyboardWillChange(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }

        let keyboardHeight = view.frame.height - frame.origin.y - view.safeAreaInsets.bottom
        inputBottomConstraint.constant = -max(0, keyboardHeight)

        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
}


extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}


extension ChatViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let maxHeight: CGFloat = 120
        let size = textView.sizeThatFits(CGSize(width: textView.frame.width, height: .greatestFiniteMagnitude))
        let newHeight = min(max(size.height, 40), maxHeight)
        textView.isScrollEnabled = size.height > maxHeight
        textViewHeightConstraint.constant = newHeight
        updateSendButtonState()
        view.layoutIfNeeded()
    }
}


// TODO: // გასაკეთბელია და აი გაკეთებულია იმპლენტაცია გასაკეთებეული როდესაც ფულს გადავიხდით 
