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

    private let upComingViewController = UINavigationController(rootViewController:
                                                                    UpComingViewController(UpComingViewModel(NetworkService())))

    private let favoriteRocketsViewController = UINavigationController(rootViewController:
                                                                    FavoriteRocketViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
       configure()
    }
    // MARK: - UI Configure
        private func configure() {
            rocketsViewController.tabBarItem.image = UIImage(named: "rocketIcon")
            rocketsViewController.title = "Rockets"

            favoriteRocketsViewController.tabBarItem.image = UIImage(systemName: "heart.fill")
            favoriteRocketsViewController.title = "Favorite Rockets"

            upComingViewController.tabBarItem.image = UIImage(systemName: "arrow.forward.square")
            upComingViewController.title = "Upcoming Launches"

            tabBar.tintColor = .systemIndigo
            tabBar.backgroundColor = .systemBackground
            setViewControllers([rocketsViewController,favoriteRocketsViewController, upComingViewController], animated: true)
        }
}
