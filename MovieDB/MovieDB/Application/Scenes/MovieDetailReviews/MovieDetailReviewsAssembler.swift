//
//  MovieDetailReviewsAssembler.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/20/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol MovieDetailReviewsAssembler {
    func resolve(movieDetail: MovieDetail) -> MovieDetailReviewsViewController
    func resolve(movieDetail: MovieDetail) -> MovieDetailReviewsViewModel
}

extension MovieDetailReviewsAssembler {
    func resolve(movieDetail: MovieDetail) -> MovieDetailReviewsViewController {
        let viewController = MovieDetailReviewsViewController.instantiate()
        let viewModel: MovieDetailReviewsViewModel = resolve(movieDetail: movieDetail)
        viewController.bindViewModel(to: viewModel)
        return viewController
    }
    
    func resolve(movieDetail: MovieDetail) -> MovieDetailReviewsViewModel {
        return MovieDetailReviewsViewModel(movieDetail: movieDetail)
    }
}
