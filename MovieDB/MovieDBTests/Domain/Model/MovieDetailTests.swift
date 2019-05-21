//
//  MovieDetailTests.swift
//  MovieDBTests
//
//  Created by tran.duc.tan on 5/21/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import XCTest
@testable import MovieDB

final class MovieDetailTests: XCTestCase {
    func test_mapping() {
        let json: [String: Any] = [
            "id": 1,
            "original_title": "Foo",
            "original_language": "en",
            "overview": "Bar",
            "runtime": 10,
            "poster_path": "",
            "backdrop_path": "",
            "vote_average": 3.4
        ]
        let movieDetail = MovieDetail(JSON: json)
        
        XCTAssertNotNil(movieDetail)
        XCTAssertEqual(movieDetail?.id, json["id"] as? Int)
        XCTAssertEqual(movieDetail?.title, json["original_title"] as? String)
        XCTAssertEqual(movieDetail?.overview, json["overview"] as? String)
        XCTAssertEqual(movieDetail?.language, json["original_language"] as? String)
        XCTAssertEqual(movieDetail?.duration, json["runtime"] as? Int)
        XCTAssertEqual(movieDetail?.posterPath, json["poster_path"] as? String)
        XCTAssertEqual(movieDetail?.backdropPath, json["backdrop_path"] as? String)
        XCTAssertEqual(movieDetail?.voteAverage, json["vote_average"] as? Double)
    }
}
