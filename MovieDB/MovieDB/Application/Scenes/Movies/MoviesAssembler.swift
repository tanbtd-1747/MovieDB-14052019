//
//  MoviesAssembler.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

protocol MoviesAssembler {
    func resolve(navigationController: UINavigationController) -> MoviesViewController
}

extension MoviesAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> MoviesViewController {
        let viewController = MoviesViewController.instantiate()
        return viewController
    }
}
