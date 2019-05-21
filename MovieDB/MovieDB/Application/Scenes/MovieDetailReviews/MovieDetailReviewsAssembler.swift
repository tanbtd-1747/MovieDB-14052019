//
//  MovieDetailReviewsAssembler.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/20/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol MovieDetailReviewsAssembler {
    func resolve() -> MovieDetailReviewsViewController
    func resolve() -> MovieDetailReviewsViewModel
}

extension MovieDetailReviewsAssembler {
    func resolve() -> MovieDetailReviewsViewController {
        let viewController = MovieDetailReviewsViewController.instantiate()
        let viewModel: MovieDetailReviewsViewModel = resolve()
        viewController.bindViewModel(to: viewModel)
        return viewController
    }
    
    func resolve() -> MovieDetailReviewsViewModel {
        return MovieDetailReviewsViewModel()
    }
}
