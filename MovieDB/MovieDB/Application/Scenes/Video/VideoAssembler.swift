//
//  VideoAssembler.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/22/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol VideoAssembler {
    func resolve(movieDetail: MovieDetail) -> VideoViewController
    func resolve(movieDetail: MovieDetail) -> VideoViewModel
}

extension VideoAssembler {
    func resolve(movieDetail: MovieDetail) -> VideoViewController {
        let viewController = VideoViewController.instantiate()
        let viewModel: VideoViewModel = resolve(movieDetail: movieDetail)
        viewController.bindViewModel(to: viewModel)
        return viewController
    }
    
    func resolve(movieDetail: MovieDetail) -> VideoViewModel {
        return VideoViewModel(movieDetail: movieDetail)
    }
}
