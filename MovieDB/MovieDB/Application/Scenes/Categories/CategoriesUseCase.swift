//
//  CategoriesUseCase.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/15/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol CategoriesUseCaseType {
    func getMoviesList() -> Observable<PagingInfo<Movie>>
    func loadMoreMoviesList(page: Int) -> Observable<PagingInfo<Movie>>
}

struct CategoriesUseCase: CategoriesUseCaseType {
    let repository: MovieRepositoryType
    
    func getMoviesList() -> Observable<PagingInfo<Movie>> {
        return loadMoreMoviesList(page: 1)
    }
    
    func loadMoreMoviesList(page: Int) -> Observable<PagingInfo<Movie>> {
        return repository.getMoviesList(page: page)
    }
}
