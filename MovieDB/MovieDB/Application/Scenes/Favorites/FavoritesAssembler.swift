//
//  FavoritesAssembler.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

protocol FavoritesAssembler {
    func resolve(navigationController: UINavigationController) -> FavoritesViewController
}

extension FavoritesAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> FavoritesViewController {
        let viewController = FavoritesViewController.instantiate()
        return viewController
    }
}
