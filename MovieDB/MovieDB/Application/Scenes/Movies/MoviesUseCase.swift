//
//  MoviesUseCase.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/15/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol MoviesUseCaseType {
    func getMoviesList(category: CategoryType) -> Observable<PagingInfo<Movie>>
    func loadMoreMoviesList(category: CategoryType, page: Int) -> Observable<PagingInfo<Movie>>
}

struct MoviesUseCase: MoviesUseCaseType {
    let repository: MovieRepositoryType
    
    func getMoviesList(category: CategoryType) -> Observable<PagingInfo<Movie>> {
        return loadMoreMoviesList(category: category, page: 1)
    }
    
    func loadMoreMoviesList(category: CategoryType, page: Int) -> Observable<PagingInfo<Movie>> {
        return repository.getMoviesList(category: category, page: page)
    }
}

