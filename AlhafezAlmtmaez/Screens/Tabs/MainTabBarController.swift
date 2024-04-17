//
//  MainTabBarController.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 14/03/2024.
//

import UIKit
import Combine

final class MainTabBarController: UITabBarController {

    // MARK: - Subviews

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - LifeCycle

    deinit {
        deinitLog(Self.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
        setupViewControllers()
    }
}

// MARK: - View Setup

extension MainTabBarController {
    private func setupTabBar() {
        self.tabBar.layer.shadowColor = UIColor(
            red: 0, green: 0, blue: 0,
            alpha: 0.1
        ).cgColor
        self.tabBar.layer.shadowOpacity = 1
        self.tabBar.layer.shadowRadius = 30 / 2
        self.tabBar.layer.shadowOffset = .init(width: 0, height: -4)
    }

    private func setupViewControllers() {
        let home = HomeScreen()
        home.tabBarItem = .init(title: .text.Home, image: .tabHomeIcon, tag: 0)

        let heros = HerosScreen()
        heros.tabBarItem = .init(title: .text.Heros, image: .tabHerosIcon, tag: 1)

        let quran = QuranScreen()
        quran.tabBarItem = .init(title: .text.Quran, image: .tabQuranIcon, tag: 2)

        let myAccount = MyAccountScreen()
        myAccount.tabBarItem = .init(title: .text.MyAccount, image: .tabMyAccountIcon, tag: 3)

        viewControllers = [
            ScreenNavigationController(rootViewController: home),
            ScreenNavigationController(rootViewController: heros),
            ScreenNavigationController(rootViewController: quran),
            ScreenNavigationController(rootViewController: myAccount),
        ]
    }
}
