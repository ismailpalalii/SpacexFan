//
//  MainTabbarController.swift
//  SpacexFan
//
//  Created by İsmail Palalı on 1.09.2022.
//

import UIKit

class MainTabbarController: UITabBarController {

    // Tabbar Items

    private let rocketsViewController = UINavigationController(rootViewController:
                                                                RocketsViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
       configure()
    }
    // MARK: - UI Configure
        private func configure() {
            rocketsViewController.tabBarItem.image = UIImage(named: "rocketIcon")
            rocketsViewController.title = "Rockets"

            tabBar.tintColor = .systemIndigo
            tabBar.backgroundColor = .systemBackground
            setViewControllers([rocketsViewController], animated: true)
        }
}
