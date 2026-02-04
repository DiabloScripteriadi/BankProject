//
//  LoadingVc.swift
//  BNK
//
//  Created by chasemedkcorto on 29.01.26.
//

import UIKit

class EmailLoadingVc: UIViewController {
    private let spinner = UIActivityIndicatorView(style: .large)
    private let minyLabel = UILabel()
    private let subtitleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
    }

    private func setupUI() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .white
        spinner.startAnimating()
        //rodesac daamtavrebs loading screens gadva onboard screenze 
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(8)) {
            print("Task executed on the main queue at: \(Date())")
            let vc = MainVC()
            self.navigationController!.pushViewController(vc, animated: true)
        }
        view.addSubview(spinner)

        minyLabel.text = "Thanks for submitting..."
        minyLabel.font = .systemFont(ofSize: 18, weight: .medium)
        minyLabel.textColor = .white
        minyLabel.textAlignment = .center
        minyLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(minyLabel)

        subtitleLabel.text = "This will be done in a few seconds. restarting an up wil stop a Whole Process"
        subtitleLabel.font = .systemFont(ofSize: 13)
        subtitleLabel.textColor = .white
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitleLabel)

        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.bottomAnchor.constraint(equalTo: minyLabel.topAnchor, constant: -16),

            minyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            minyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),

       
            subtitleLabel.topAnchor.constraint(equalTo: minyLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
}
