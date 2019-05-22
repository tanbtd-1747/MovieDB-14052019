//
//  MovieDetailOverviewAssembler.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/21/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol MovieDetailOverviewAssembler {
    func resolve(movieDetail: MovieDetail) -> MovieDetailOverviewViewController
    func resolve(movieDetail: MovieDetail) -> MovieDetailOverviewViewModel
}

extension MovieDetailOverviewAssembler {
    func resolve(movieDetail: MovieDetail) -> MovieDetailOverviewViewController {
        let viewController = MovieDetailOverviewViewController.instantiate()
        
        let viewModel: MovieDetailOverviewViewModel = resolve(movieDetail: movieDetail)
        viewController.bindViewModel(to: viewModel)
        return viewController
    }
    
    func resolve(movieDetail: MovieDetail) -> MovieDetailOverviewViewModel {
        return MovieDetailOverviewViewModel(movieDetail: movieDetail)
    }
}
