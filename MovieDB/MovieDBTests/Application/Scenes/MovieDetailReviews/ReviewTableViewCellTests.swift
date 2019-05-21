//
//  ReviewTableViewCellTests.swift
//  MovieDBTests
//
//  Created by tran.duc.tan on 5/21/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import XCTest
@testable import MovieDB

final class ReviewTableViewCellTests: XCTestCase {
    private var cell: ReviewTableViewCell!

    override func setUp() {
        super.setUp()
        cell = ReviewTableViewCell.loadFromNib()
    }
    
    func test_ibOutlets() {
        XCTAssertNotNil(cell)
        XCTAssertNotNil(cell.reviewImageView)
        XCTAssertNotNil(cell.reviewNameLabel)
        XCTAssertNotNil(cell.reviewContentLabel)
    }
}
