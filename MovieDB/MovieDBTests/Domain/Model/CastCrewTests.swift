//
//  CastCrewTests.swift
//  MovieDBTests
//
//  Created by tran.duc.tan on 5/21/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import XCTest
@testable import MovieDB

final class CastCrewTests: XCTestCase {
    func test_mapping() {
        let json: [String: Any] = [
            "id": 1,
            "name": "Foo",
            "profile_path": ""
        ]
        let castCrew = CastCrew(JSON: json)
        
        XCTAssertNotNil(castCrew)
        XCTAssertEqual(castCrew?.id, json["id"] as? Int)
        XCTAssertEqual(castCrew?.name, json["name"] as? String)
        XCTAssertEqual(castCrew?.profilePath, json["profile_path"] as? String)
    }
}
