//
//  BNKTabBarController.swift
//  BNK
//
//  Created by chasemedkcorto on 11.11.26.
//

import UIKit

final class BNKTabBarController: UITabBarController, UITabBarControllerDelegate {

    private enum TabIndex: Int {
        case home = 0
        case space = 1
        case plus = 2
        case offers = 3
        case profile = 4
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setupAppearance()
        setupTabs()
    }

    private func setupAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .systemBackground
        appearance.shadowColor = .separator

        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
        tabBar.tintColor = .label
        tabBar.unselectedItemTintColor = .secondaryLabel
    }

    private func setupTabs() {
        // მთავარი (Home)
        let homeVC = MainVC()
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(title: "Main",
                                          image: UIImage(systemName: "house"),
                                          selectedImage: UIImage(systemName: "house.fill"))

        // სივრცე (Space)
        let spaceVC = SpaceVC()
        let spaceNav = UINavigationController(rootViewController: spaceVC)
        spaceNav.tabBarItem = UITabBarItem(title: "Space",
                                           image: UIImage(systemName: "square.grid.2x2"),
                                           selectedImage: UIImage(systemName: "square.grid.2x2.fill"))

        // ცენტრის პლიუსი (მოქმედება בלבד)
        let centerVC = UIViewController()
        let basePlus = UIImage(systemName: "plus.circle.fill")
        let biggerPlus = basePlus?.applyingSymbolConfiguration(.init(pointSize: 26, weight: .bold))
        let blackPlus = biggerPlus?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let centerItem = UITabBarItem(title: nil, image: blackPlus, selectedImage: blackPlus)
        centerItem.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 0)
        centerVC.tabBarItem = centerItem

        // შეთავაზებები (Offers)
        let offersVC = OffersVc()
        let offersNav = UINavigationController(rootViewController: offersVC)
        offersNav.tabBarItem = UITabBarItem(title: "Offers",
                                            image: UIImage(systemName: "tag"),
                                            selectedImage: UIImage(systemName: "tag.fill"))

        // პროფილი (Profile)
        let profileVC = ProfileVC()
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(title: "Profile",
                                             image: UIImage(systemName: "person.crop.circle"),
                                             selectedImage: UIImage(systemName: "person.crop.circle.fill"))

        viewControllers = [homeNav, spaceNav, centerVC, offersNav, profileNav]
        selectedIndex = TabIndex.home.rawValue
    }

    func tabBarController(_ tabBarController: UITabBarController,
                          shouldSelect viewController: UIViewController) -> Bool {
        guard let vcs = viewControllers,
              let index = vcs.firstIndex(of: viewController) else { return true }

        if index == TabIndex.plus.rawValue {
            presentAddCard()
            return false
        }
        return true
    }

    private func presentAddCard() {
        let addVC = AddCardVc()
        // MainVC-ს მივაბათ delegate, რომ ბარათის შექმნის შემდეგ იმუშაოს მის UI-ში
        if let homeNav = viewControllers?[TabIndex.home.rawValue] as? UINavigationController,
           let main = homeNav.viewControllers.first as? MainVC {
            addVC.delegate = main
        }

        let nav = UINavigationController(rootViewController: addVC)
        nav.modalPresentationStyle = .pageSheet
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 24
        }
        present(nav, animated: true)
    }
}
