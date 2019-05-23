//
//  FavoritesNavigator.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/22/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol FavoritesNavigatorType {
    func toFavoritesDetail(movies: Movie)
}

struct FavoritesListNavigator: FavoritesNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toFavoritesDetail(movies: Movie) {
        let viewController: MovieDetailViewController = assembler.resolve(navigationController: navigationController,
                                                                          movie: movies)
        navigationController.pushViewController(viewController, animated: true)
    }
}

