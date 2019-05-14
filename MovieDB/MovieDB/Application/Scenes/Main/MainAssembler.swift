//
//  MainAssembler.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

protocol MainAssembler {
    func resolve(tabBarController: UITabBarController) -> MainViewController
}

extension MainAssembler {
    func resolve(tabBarController: UITabBarController) -> MainViewController {
        let viewController = MainViewController.instantiate()
        return viewController
    }
}
