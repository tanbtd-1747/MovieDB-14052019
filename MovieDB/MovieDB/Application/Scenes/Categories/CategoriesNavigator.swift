//
//  CategoriesNavigator.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/15/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol CategoriesNavigatorType {
    func toMovieDetail(movie: Movie)
}

struct CategoriesNavigator: CategoriesNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toMovieDetail(movie: Movie) {
        let viewController: MovieDetailViewController = assembler.resolve(navigationController: navigationController,
                                                                          movie: movie)
        navigationController.pushViewController(viewController, animated: true)
    }
}
