//
//  MovieDetailNavigatorMock.swift
//  MovieDBTests
//
//  Created by tran.duc.tan on 5/21/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

@testable import MovieDB

final class MovieDetailNavigatorMock: MovieDetailNavigatorType {
    var toCategoriesCalled = false
    
    func toCategories() {
        toCategoriesCalled = true
    }
    
    var toMovieDetailOverviewCalled = false
    
    func toMovieDetailOverview(movieDetail: MovieDetail) {
        toMovieDetailOverviewCalled = true
    }
    
    var toMovieDetailReviewsCalled = false
    
    func toMovieDetailReviews(movieDetail: MovieDetail) {
        toMovieDetailReviewsCalled = true
    }
    
    var toVideoCalled = false
    
    func toVideo(movieDetail: MovieDetail) {
        toVideoCalled = true
    }
    
    var toCastCrewCalled = false
    
    func toCastCrew(castCrew: CastCrew) {
        toCastCrewCalled = true
    }
}
