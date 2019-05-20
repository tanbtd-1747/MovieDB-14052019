//
//  CategoriesNavigator.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/15/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol CategoriesNavigatorType {
    func toMovieDetail()
}

struct CategoriesNavigator: CategoriesNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toMovieDetail() {
        let viewController: MovieDetailViewController = assembler.resolve()
        navigationController.pushViewController(viewController, animated: true)
    }
}
