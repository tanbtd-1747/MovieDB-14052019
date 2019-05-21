//
//  MovieDetailRepository.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/21/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol MovieDetailRepositoryType {
    func getMovieDetail(id: Int) -> Observable<MovieDetail>
}

final class MovieDetailRepository: MovieDetailRepositoryType {
    func getMovieDetail(id: Int) -> Observable<MovieDetail> {
        let input = API.GetMovieDetailInput(id: id)
        return API.shared.getMovieDetail(input)
    }
}
