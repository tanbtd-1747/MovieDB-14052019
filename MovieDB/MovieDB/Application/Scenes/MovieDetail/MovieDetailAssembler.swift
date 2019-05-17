//
//  MovieDetailAssembler.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/17/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol MovieDetailAssembler {
    func resolve() -> MovieDetailViewController
}

extension MovieDetailAssembler {
    func resolve() -> MovieDetailViewController {
        let viewController = MovieDetailViewController.instantiate()
        return viewController
    }
}
