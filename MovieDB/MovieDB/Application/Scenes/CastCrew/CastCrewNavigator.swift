//
//  CastCrewNavigator.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/23/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol CastCrewNavigatorType {
    func toMovieDetail()
    func toMovieDetail(movie: Movie)
}

struct CastCrewNavigator: CastCrewNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toMovieDetail() {
        navigationController.popViewController(animated: true)
    }
    
    func toMovieDetail(movie: Movie) {
        let viewController: MovieDetailViewController = assembler.resolve(navigationController: navigationController,
                                                                          movie: movie)
        navigationController.pushViewController(viewController, animated: true)
    }
}
