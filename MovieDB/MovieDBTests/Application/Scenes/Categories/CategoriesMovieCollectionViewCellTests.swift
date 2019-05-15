//
//  CategoriesMovieCollectionViewCellTests.swift
//  MovieDBTests
//
//  Created by tran.duc.tan on 5/15/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import XCTest
@testable import MovieDB

final class CategoriesMovieCollectionViewCellTests: XCTestCase {
    private var cell: CategoriesMovieCollectionViewCell!

    override func setUp() {
        super.setUp()
        cell = CategoriesMovieCollectionViewCell.loadFromNib()
    }

    func test_ibOutlets() {
        XCTAssertNotNil(cell)
        XCTAssertNotNil(cell.shadowView)
        XCTAssertNotNil(cell.containerView)
        XCTAssertNotNil(cell.movieImageView)
        XCTAssertNotNil(cell.movieNameLabel)
        XCTAssertNotNil(cell.movieYearLabel)
        XCTAssertNotNil(cell.movieVoteLabel)
    }
}
