//
//  CastCrewNavigatorMock.swift
//  MovieDBTests
//
//  Created by tran.duc.tan on 5/23/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

@testable import MovieDB

final class CastCrewNavigatorMock: CastCrewNavigatorType {
    var toMovieDetailCalled = false
    
    func toMovieDetail() {
        toMovieDetailCalled = true
    }
    
    var toMovieDetailCalledWithMovie = false
    
    func toMovieDetail(movie: Movie) {
        toMovieDetailCalledWithMovie = true
    }
}
