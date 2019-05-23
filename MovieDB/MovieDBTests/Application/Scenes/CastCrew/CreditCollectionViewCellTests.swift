//
//  CreditCollectionViewCell.swift
//  MovieDBTests
//
//  Created by tran.duc.tan on 5/23/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import XCTest
@testable import MovieDB

final class CreditCollectionViewCellTests: XCTestCase {
    private var cell: CreditCollectionViewCell!

    override func setUp() {
        super.setUp()
        cell = CreditCollectionViewCell.loadFromNib()
    }
    
    func test_ibOutlets() {
        XCTAssertNotNil(cell)
        XCTAssertNotNil(cell.shadowView)
        XCTAssertNotNil(cell.creditImageView)
    }
}
