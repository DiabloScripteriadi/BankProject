//
//  BNKTabBarController.swift
//  BNK
//
//  Created by chasemedkcorto on 11.11.26.
//

import UIKit

final class BNKTabBarController: UITabBarController, UITabBarControllerDelegate {

    private enum TabIndex: Int {
        case main = 0
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
        // 1. Main
        let mainVC = MainVC()
        let mainNav = UINavigationController(rootViewController: mainVC)
        mainNav.tabBarItem = UITabBarItem(title: "Main",
                                          image: UIImage(systemName: "house"),
                                          selectedImage: UIImage(systemName: "house.fill"))

        // 2. Space
        let spaceVC = SpaceVC()
        let spaceNav = UINavigationController(rootViewController: spaceVC)
        spaceNav.tabBarItem = UITabBarItem(title: "Space",
                                           image: UIImage(systemName: "square.grid.2x2"),
                                           selectedImage: UIImage(systemName: "square.grid.2x2.fill"))

        // 3. Plus (action-only)
        let plusDummy = UIViewController()
        plusDummy.view.backgroundColor = .clear
        plusDummy.tabBarItem = UITabBarItem(title: nil,
                                            image: UIImage(systemName: "plus.circle"),
                                            selectedImage: UIImage(systemName: "plus.circle.fill"))
        // უფრო目ყავი ცენტრში
        plusDummy.tabBarItem.imageInsets = UIEdgeInsets(top: -2, left: 0, bottom: 2, right: 0)

        // 4. Offers
        let offersVC = OffersVc()
        let offersNav = UINavigationController(rootViewController: offersVC)
        offersNav.tabBarItem = UITabBarItem(title: "Offers",
                                            image: UIImage(systemName: "tag"),
                                            selectedImage: UIImage(systemName: "tag.fill"))

        // 5. Profile
        let profileVC = ProfileVC()
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(title: "Profile",
                                             image: UIImage(systemName: "person.crop.circle"),
                                             selectedImage: UIImage(systemName: "person.crop.circle.fill"))

        viewControllers = [mainNav, spaceNav, plusDummy, offersNav, profileNav]
        selectedIndex = TabIndex.main.rawValue
    }

    // Center Plus: intercept selection to present AddCardVc
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
        // თუ გინდათ MainVC-ს დაებმოს დელეგატი, ვიპოვოთ MainVC-ს instance
        if let mainNav = viewControllers?[TabIndex.main.rawValue] as? UINavigationController,
           let main = mainNav.viewControllers.first as? MainVC {
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
