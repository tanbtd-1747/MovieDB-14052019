//
//  CastCrewViewControllerTests.swift
//  MovieDBTests
//
//  Created by tran.duc.tan on 5/23/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import XCTest
@testable import MovieDB

final class CastCrewViewControllerTests: XCTestCase {
    private var viewController: CastCrewViewController!

    override func setUp() {
        super.setUp()
        viewController = CastCrewViewController.instantiate()
    }
    
    func test_ibOutlets() {
        _ = viewController.view
        
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(viewController.castCrewImageView)
        XCTAssertNotNil(viewController.castCrewNameLabel)
        XCTAssertNotNil(viewController.castCrewSegmentedControl)
        XCTAssertNotNil(viewController.castCrewCreditsCollectionView)
        XCTAssertNotNil(viewController.backButton)
    }
}
