

//
//  Untitled.swift
//  BankProject(BOG)
//
//  Created by chasemedkcorto on 05.01.26.
//
import UIKit
class OnboardingVC: UIViewController {
    private let titleLabel = UILabel()
    private let titleimage = UIImageView()
    private let subtitleLabel = UILabel()
    private let subtitleImage = UIImageView()
    private let minyLabel = UILabel()
    private let loginBtn = UIButton(type: .system)
    private let getStartedBtn = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupTitle()
        setupImage()
        setupSubtitle()
        setupButtons()
        setupminyLabel()
        setupminyLabel()
    }

    private func setupTitle() {
        titleLabel.text = "Swift Pay"
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.textColor = .black
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setupImage() {
            titleimage.image = UIImage(named: "splashscreen")
            titleimage.layer.cornerRadius = 10
            titleimage.layer.masksToBounds = true
            view.addSubview(titleimage)
            titleimage.translatesAutoresizingMaskIntoConstraints = false
            
            subtitleImage.image = UIImage(named: "onboardimage")
            subtitleImage.layer.cornerRadius = 15
            subtitleImage.layer.masksToBounds = true
            view.addSubview(subtitleImage)
            subtitleImage.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                titleimage.topAnchor.constraint(equalTo: view.topAnchor, constant: 135),
                titleimage.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -50),
                titleimage.widthAnchor.constraint(equalToConstant: 35),
                titleimage.heightAnchor.constraint(equalToConstant: 35),
                
                subtitleImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 75),
                subtitleImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                subtitleImage.widthAnchor.constraint(equalToConstant: 340),
                subtitleImage.heightAnchor.constraint(equalToConstant: 340),
            ])
    }

    private func setupSubtitle() {
        subtitleLabel.text = "Open a mobile money account in minutes."
        subtitleLabel.font = .systemFont(ofSize: 30, weight: .semibold)
        subtitleLabel.textColor = .black
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
        view.addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: subtitleImage.bottomAnchor, constant: 24),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
    private func setupminyLabel() {
        minyLabel.text = "Get sending, spending and saving with your contactless card"
        minyLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        minyLabel.textColor = .gray
        
        minyLabel.numberOfLines = 0
        minyLabel.textAlignment = .center
        view.addSubview(minyLabel)
        minyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minyLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 24),
            minyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            minyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
    private func setupButtons() {
        loginBtn.setTitle("Login", for: .normal)
        loginBtn.backgroundColor = .systemGray5
        loginBtn.setTitleColor(.black, for: .normal)
        loginBtn.layer.cornerRadius = 12
        loginBtn.addTarget(self, action: #selector(goToLoginPage), for: .touchUpInside)
        getStartedBtn.setTitle("Get Started", for: .normal)
        getStartedBtn.backgroundColor = .black
        getStartedBtn.setTitleColor(.white, for: .normal)
        getStartedBtn.layer.cornerRadius = 12
        getStartedBtn.addTarget(self, action: #selector(goToGetstartedPage), for: .touchUpInside)
        view.addSubview(loginBtn)
        view.addSubview(getStartedBtn)
      
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        getStartedBtn.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            loginBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            loginBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            loginBtn.heightAnchor.constraint(equalToConstant: 52),
            loginBtn.widthAnchor.constraint(equalTo: getStartedBtn.widthAnchor),
 
            getStartedBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            getStartedBtn.centerYAnchor.constraint(equalTo: loginBtn.centerYAnchor),
            getStartedBtn.heightAnchor.constraint(equalToConstant: 52),

            loginBtn.trailingAnchor.constraint(equalTo: getStartedBtn.leadingAnchor, constant: -16)
        ])
    }
    @objc func goToLoginPage() {
        let vc = loginVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func goToGetstartedPage() {
        let vc = GetStartedVc()
        navigationController?.pushViewController(vc, animated: true)
    }
}
