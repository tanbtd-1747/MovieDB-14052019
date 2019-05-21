//
//  CategoriesNavigatorMock.swift
//  MovieDBTests
//
//  Created by tran.duc.tan on 5/16/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

@testable import MovieDB

final class CategoriesNavigatorMock: CategoriesNavigatorType {
    var toMovieDetailCalled = false
    
    func toMovieDetail(movie: Movie) {
        toMovieDetailCalled = true
    }
}
