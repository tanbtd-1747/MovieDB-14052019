//
//  CategoriesViewModel.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/15/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

struct CategoriesViewModel {
    let navigator: CategoriesNavigatorType
    let useCase: CategoriesUseCaseType
}

extension CategoriesViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let loadMoreTrigger: Driver<Void>
    }
    
    struct Output {
        let error: Driver<Error>
        let loading: Driver<Bool>
        let refreshing: Driver<Bool>
        let loadingMore: Driver<Bool>
        let fetchItems: Driver<Void>
        let moviesList: Driver<[Movie]>
    }
    
    func transform(_ input: CategoriesViewModel.Input) -> CategoriesViewModel.Output {
        let loadMoreOutput = setupLoadMorePaging(loadTrigger: input.loadTrigger,
                                                 getItems: useCase.getMoviesList,
                                                 refreshTrigger: input.reloadTrigger,
                                                 refreshItems: useCase.getMoviesList,
                                                 loadMoreTrigger: input.loadMoreTrigger,
                                                 loadMoreItems: useCase.loadMoreMoviesList)
        
        let (page, fetchItems, loadError, loading, refreshing, loadingMore) = loadMoreOutput
        
        let moviesList = page
            .map {
                $0.items
            }
            .asDriverOnErrorJustComplete()
        
        return Output(
            error: loadError,
            loading: loading,
            refreshing: refreshing,
            loadingMore: loadingMore,
            fetchItems: fetchItems,
            moviesList: moviesList
        )
    }
}
