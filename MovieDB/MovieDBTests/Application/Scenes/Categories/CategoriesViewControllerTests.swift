//
//  CategoriesViewControllerTests.swift
//  MovieDBTests
//
//  Created by tran.duc.tan on 5/15/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import XCTest
@testable import MovieDB

final class CategoriesViewControllerTests: XCTestCase {
    private var viewController: CategoriesViewController!

    override func setUp() {
        super.setUp()
        viewController = CategoriesViewController.instantiate()
    }
    
    func test_ibOutlets() {
        _ = viewController.view
        XCTAssertNotNil(viewController.categoriesSegmentedControl)
        XCTAssertNotNil(viewController.categoriesMoviesCollectionView)
    }
}
