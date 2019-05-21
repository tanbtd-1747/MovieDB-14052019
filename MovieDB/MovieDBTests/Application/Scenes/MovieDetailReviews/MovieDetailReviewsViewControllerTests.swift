//
//  MovieDetailReviewsViewControllerTests.swift
//  MovieDBTests
//
//  Created by tran.duc.tan on 5/21/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import XCTest
@testable import MovieDB

final class MovieDetailReviewsViewControllerTests: XCTestCase {
    private var viewController: MovieDetailReviewsViewController!

    override func setUp() {
        super.setUp()
        viewController = MovieDetailReviewsViewController.instantiate()
    }

    func test_ibOutlets() {
        _ = viewController.view
        
        XCTAssertNotNil(viewController.containerView)
        XCTAssertNotNil(viewController.closeButton)
        XCTAssertNotNil(viewController.reviewsTableView)
    }
}
