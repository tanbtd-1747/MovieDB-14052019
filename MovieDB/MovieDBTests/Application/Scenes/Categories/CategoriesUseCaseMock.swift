//
//  CategoriesUseCaseMock.swift
//  MovieDBTests
//
//  Created by tran.duc.tan on 5/16/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import RxSwift
@testable import MovieDB

final class CategoriesUseCaseMock: CategoriesUseCaseType {
    var getMoviesListCalled = false
    
    var getMoviesListReturnValue: Observable<PagingInfo<Movie>> = {
        let items = [Movie().with { $0.id = 1 } ]
        let page = PagingInfo<Movie>(page: 1, items: items)
        return Observable.just(page)
    }()
    
    func getMoviesList() -> Observable<PagingInfo<Movie>> {
        getMoviesListCalled = true
        return getMoviesListReturnValue
    }
    
    var loadMoreMoviesListCalled = false
    
    var loadMoreMoviesListReturnValue: Observable<PagingInfo<Movie>> = {
        let items = [Movie().with { $0.id = 2 } ]
        let page = PagingInfo<Movie>(page: 2, items: items)
        return Observable.just(page)
    }()
    
    func loadMoreMoviesList(page: Int) -> Observable<PagingInfo<Movie>> {
        loadMoreMoviesListCalled = true
        return loadMoreMoviesListReturnValue
    }
}
