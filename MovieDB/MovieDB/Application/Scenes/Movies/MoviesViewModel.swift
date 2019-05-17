//
//  MoviesViewModel.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/15/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

struct MoviesViewModel {
    let navigator: MoviesNavigatorType
    let useCase: MoviesUseCaseType
}

// MARK: - ViewModelType
extension MoviesViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<CategoryType>
        let reloadTrigger: Driver<CategoryType>
        let loadMoreTrigger: Driver<CategoryType>
        let selectRepoTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let error: Driver<Error>
        let loading: Driver<Bool>
        let refreshing: Driver<Bool>
        let loadingMore: Driver<Bool>
        let fetchItems: Driver<Void>
        let repoList: Driver<[Movie]>
        let selectedRepo: Driver<Void>
        let isEmptyData: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let loadMoreOutput = setupLoadMorePagingWithParam(
            loadTrigger: input.loadTrigger,
            getItems: useCase.getMoviesList,
            refreshTrigger: input.reloadTrigger,
            refreshItems: useCase.getMoviesList,
            loadMoreTrigger: input.loadMoreTrigger,
            loadMoreItems: useCase.loadMoreMoviesList)
        
        let (page, fetchItems, loadError, loading, refreshing, loadingMore) = loadMoreOutput
        
        let repoList = page
            .map { $0.items.map { $0 } }
            .asDriverOnErrorJustComplete()
        
        let selectedRepo = input.selectRepoTrigger
            .withLatestFrom(repoList) {
                return ($0, $1)
            }
            .map { indexPath, repoList in
                return repoList[indexPath.row]
            }
            .do(onNext: { _ in
                //self.navigator.toRepoDetail(repo: repo)
            })
            .mapToVoid()
        
        let isEmptyData = checkIfDataIsEmpty(fetchItemsTrigger: fetchItems,
                                             loadTrigger: Driver.merge(loading, refreshing),
                                             items: repoList)
        
        return Output(
            error: loadError,
            loading: loading,
            refreshing: refreshing,
            loadingMore: loadingMore,
            fetchItems: fetchItems,
            repoList: repoList,
            selectedRepo: selectedRepo,
            isEmptyData: isEmptyData
        )
    }
}
