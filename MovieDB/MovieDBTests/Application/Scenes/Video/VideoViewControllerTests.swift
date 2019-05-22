//
//  VideoViewControllerTests.swift
//  MovieDBTests
//
//  Created by tran.duc.tan on 5/22/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import XCTest
@testable import MovieDB

final class VideoViewControllerTests: XCTestCase {
    private var viewController: VideoViewController!
    
    override func setUp() {
        super.setUp()
        viewController = VideoViewController.instantiate()
    }
    
    func test_ibOutlets() {
        _ = viewController.view
        
        XCTAssertNotNil(viewController.videoTitleLabel)
        XCTAssertNotNil(viewController.videoPlayerView)
    }
}
