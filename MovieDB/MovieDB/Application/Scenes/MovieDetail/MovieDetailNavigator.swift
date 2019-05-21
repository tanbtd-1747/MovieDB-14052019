//
//  MovieDetailNavigator.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/20/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol MovieDetailNavigatorType {
    func toCategories()
    func toMovieDetailReviews()
    func toMovieDetailOverview()
    func toCastCrew()
}

struct MovieDetailNavigator: MovieDetailNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toCategories() {
        navigationController.popViewController(animated: true)
    }
    
    func toMovieDetailReviews() {
        let reviewsViewController: MovieDetailReviewsViewController = assembler.resolve()
        
        if let detailViewController = navigationController.topViewController as? MovieDetailViewController {
            detailViewController.addBottomSheetViewController(reviewsViewController)
        }
    }
    
    func toMovieDetailOverview() {
        let overviewViewController: MovieDetailOverviewViewController = assembler.resolve()
        
        if let detailViewController = navigationController.topViewController as? MovieDetailViewController {
            detailViewController.addBottomSheetViewController(overviewViewController)
        }
    }
    
    func toCastCrew() {
        let viewController: CastCrewViewController = assembler.resolve()
        navigationController.pushViewController(viewController, animated: true)
    }
}
