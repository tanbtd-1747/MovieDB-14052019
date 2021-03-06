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
    func toVideo(movieDetail: MovieDetail)
    func toCastCrew(castCrew: CastCrew)
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
    
    func toVideo(movieDetail: MovieDetail) {
        let videoViewController: VideoViewController = assembler.resolve(movieDetail: movieDetail)
        
        if let detailViewController = navigationController.topViewController as? MovieDetailViewController {
            detailViewController.addTopSheetViewController(videoViewController)
        }
    }
    
    func toCastCrew(castCrew: CastCrew) {
        let viewController: CastCrewViewController = assembler.resolve(navigationController: navigationController,
                                                                       castCrew: castCrew)
        navigationController.pushViewController(viewController, animated: true)
    }
}
