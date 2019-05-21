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
        let loadTrigger: Driver<CategoryType>
        let reloadTrigger: Driver<CategoryType>
        let loadMoreTrigger: Driver<CategoryType>
        let selectMovieTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let error: Driver<Error>
        let loading: Driver<Bool>
        let refreshing: Driver<Bool>
        let loadingMore: Driver<Bool>
        let fetchItems: Driver<Void>
        let moviesList: Driver<[Movie]>
        let selectedMovie: Driver<Void>
        let scrollToTop: Driver<Void>
        let isEmptyData: Driver<Bool>
    }
    
    func transform(_ input: CategoriesViewModel.Input) -> CategoriesViewModel.Output {
        let loadMoreOutput = setupLoadMorePagingWithParam(loadTrigger: input.loadTrigger,
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
        
        let selectedMovie = input.selectMovieTrigger
            .withLatestFrom(moviesList) {
                return ($0, $1)
            }
            .map { indexPath, moviesList in
                return moviesList[indexPath.row]
            }
            .do(onNext: { movie in
                self.navigator.toMovieDetail(movie: movie)
            })
            .mapToVoid()
        
        let isEmptyData = checkIfDataIsEmpty(fetchItemsTrigger: fetchItems,
                                             loadTrigger: Driver.merge(loading, refreshing),
                                             items: moviesList)
        
        return Output(
            error: loadError,
            loading: loading,
            refreshing: refreshing,
            loadingMore: loadingMore,
            fetchItems: fetchItems,
            moviesList: moviesList,
            selectedMovie: selectedMovie,
            scrollToTop: input.loadTrigger.mapToVoid(),
            isEmptyData: isEmptyData
        )
    }
}
