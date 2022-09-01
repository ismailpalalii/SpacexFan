//
//  MainTabbarController.swift
//  SpacexFan
//
//  Created by İsmail Palalı on 1.09.2022.
//

import UIKit

final class MainTabbarController: UITabBarController {

    // MARK: Tabbar Items

    private let rocketsViewController = UINavigationController(rootViewController:
                                                                RocketsViewController(RocketsViewModel(NetworkService())))

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
