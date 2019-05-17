//
//  MovieRepository.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/16/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol MovieRepositoryType {
    func getMoviesList(category: CategoryType, page: Int) -> Observable<PagingInfo<Movie>>
}

final class MovieRepository: MovieRepositoryType {
    func getMoviesList(category: CategoryType, page: Int) -> Observable<PagingInfo<Movie>> {
        let input = API.GetMoviesListInput(category: category, page: page)
        return API.shared.getMoviesList(input)
            .map { output in
                guard let movies = output.movies else {
                    throw APIInvalidResponseError()
                }
                return PagingInfo<Movie>(page: page, items: movies)
            }
    }
}
