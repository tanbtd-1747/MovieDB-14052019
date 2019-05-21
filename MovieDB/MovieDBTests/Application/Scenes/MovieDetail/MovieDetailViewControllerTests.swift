//
//  MovieDetailViewControllerTests.swift
//  MovieDBTests
//
//  Created by tran.duc.tan on 5/21/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import XCTest
@testable import MovieDB

final class MovieDetailViewControllerTests: XCTestCase {
    private var viewController: MovieDetailViewController!

    override func setUp() {
        super.setUp()
        viewController = MovieDetailViewController.instantiate()
    }

    func test_ibOutlets() {
        _ = viewController.view
        
        XCTAssertNotNil(viewController.movieBackdropImageView)
        XCTAssertNotNil(viewController.moviePosterImageView)
        XCTAssertNotNil(viewController.movieTitleLabel)
        XCTAssertNotNil(viewController.movieRatingView)
        XCTAssertNotNil(viewController.movieLanguageLabel)
        XCTAssertNotNil(viewController.movieDurationLabel)
        XCTAssertNotNil(viewController.movieOverviewLabel)
        XCTAssertNotNil(viewController.movieCastCrewCollectionView)
        XCTAssertNotNil(viewController.favoriteButton)
        XCTAssertNotNil(viewController.reviewsButton)
        XCTAssertNotNil(viewController.backButton)
        XCTAssertNotNil(viewController.playButton)
    }
}
