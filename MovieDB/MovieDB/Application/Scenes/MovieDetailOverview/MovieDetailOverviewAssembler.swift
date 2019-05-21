//
//  MovieDetailOverviewAssembler.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/21/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol MovieDetailOverviewAssembler {
    func resolve() -> MovieDetailOverviewViewController
    func resolve() -> MovieDetailOverviewViewModel
}

extension MovieDetailOverviewAssembler {
    func resolve() -> MovieDetailOverviewViewController {
        let viewController = MovieDetailOverviewViewController.instantiate()
        
        let viewModel: MovieDetailOverviewViewModel = resolve()
        viewController.bindViewModel(to: viewModel)
        return viewController
    }
    
    func resolve() -> MovieDetailOverviewViewModel {
        return MovieDetailOverviewViewModel()
    }
}
