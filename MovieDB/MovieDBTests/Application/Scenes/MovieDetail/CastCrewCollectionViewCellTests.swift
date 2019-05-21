//
//  CastCrewCollectionViewCellTests.swift
//  MovieDBTests
//
//  Created by tran.duc.tan on 5/21/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import XCTest
@testable import MovieDB

final class CastCrewCollectionViewCellTests: XCTestCase {
    private var cell: CastCrewCollectionViewCell!

    override func setUp() {
        super.setUp()
        cell = CastCrewCollectionViewCell.loadFromNib()
    }
    
    func test_ibOutlets() {
        XCTAssertNotNil(cell)
        XCTAssertNotNil(cell.crewImageView)
        XCTAssertNotNil(cell.crewNameLabel)
    }
}
