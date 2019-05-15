//
//  FavoritesAssembler.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

protocol FavoritesAssembler {
    func resolve() -> FavoritesViewController
}

extension FavoritesAssembler where Self: DefaultAssembler {
    func resolve() -> FavoritesViewController {
        let viewController = FavoritesViewController.instantiate()
        return viewController
    }
}