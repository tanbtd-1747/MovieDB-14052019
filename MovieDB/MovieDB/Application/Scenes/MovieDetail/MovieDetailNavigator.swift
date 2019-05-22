//
//  MovieDetailNavigator.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/20/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol MovieDetailNavigatorType {
    func toCategories()
    func toMovieDetailReviews(movieDetail: MovieDetail)
    func toMovieDetailOverview(movieDetail: MovieDetail)
    func toCastCrew()
}

struct MovieDetailNavigator: MovieDetailNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toCategories() {
        navigationController.popViewController(animated: true)
    }
    
    func toMovieDetailReviews(movieDetail: MovieDetail) {
        let reviewsViewController: MovieDetailReviewsViewController = assembler.resolve(movieDetail: movieDetail)
        
        if let detailViewController = navigationController.topViewController as? MovieDetailViewController {
            detailViewController.addBottomSheetViewController(reviewsViewController)
        }
    }
    
    func toMovieDetailOverview(movieDetail: MovieDetail) {
        let overviewViewController: MovieDetailOverviewViewController = assembler.resolve(movieDetail: movieDetail)
        
        if let detailViewController = navigationController.topViewController as? MovieDetailViewController {
            detailViewController.addBottomSheetViewController(overviewViewController)
        }
    }
    
    func toCastCrew() {
        let viewController: CastCrewViewController = assembler.resolve()
        navigationController.pushViewController(viewController, animated: true)
    }
}
