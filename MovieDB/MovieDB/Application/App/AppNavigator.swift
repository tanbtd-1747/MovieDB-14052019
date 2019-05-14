//
//  AppNavigator.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

protocol AppNavigatorType {
    func toMain()
}

struct AppNavigator: AppNavigatorType {
    unowned let assembler: Assembler
    unowned let window: UIWindow
    
    func toMain() {
        let tabBarController = UITabBarController()
        let viewController: MainViewController = assembler.resolve(tabBarController: tabBarController)
        tabBarController.setViewControllers([viewController], animated: true)
        window.rootViewController = tabBarController
    }
}
