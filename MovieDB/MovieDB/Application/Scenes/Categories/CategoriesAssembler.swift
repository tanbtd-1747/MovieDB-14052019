//
//  CategoriesAssembler.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

protocol CategoriesAssembler {
    func resolve() -> CategoriesViewController
}

extension CategoriesAssembler where Self: DefaultAssembler {
    func resolve() -> CategoriesViewController {
        let viewController = CategoriesViewController.instantiate()
        return viewController
    }
}
