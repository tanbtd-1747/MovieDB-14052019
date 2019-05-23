//
//  MovieDetailUseCaseMock.swift
//  MovieDBTests
//
//  Created by tran.duc.tan on 5/21/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

@testable import MovieDB

final class MovieDetailUseCaseMock: MovieDetailUseCaseType {
    func getMovieDetail(id: Int) -> Observable<MovieDetail> {
        var movieDetail = MovieDetail()
        movieDetail.casts = [CastCrew(id: 10, name: "Foo", profilePath: "Bar")]
        return Observable.just(movieDetail)
    }
}
