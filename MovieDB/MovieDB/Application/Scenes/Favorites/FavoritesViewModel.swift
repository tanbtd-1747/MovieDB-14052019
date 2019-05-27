//
//  FavoritesViewModel.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/22/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

struct FavoritesViewModel {
    let navigator: FavoritesNavigatorType
    let useCase: FavoritesUseCaseType
}

// MARK: - ViewModelType
extension FavoritesViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let loadMoreTrigger: Driver<Void>
        let selectFavoritesTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let error: Driver<Error>
        let loading: Driver<Bool>
        let refreshing: Driver<Bool>
        let loadingMore: Driver<Bool>
        let fetchItems: Driver<Void>
        let favoritesList: Driver<[Favorite]>
        let selectedFavorites: Driver<Void>
        let isEmptyData: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let loadMoreOutput = setupLoadMorePaging(
            loadTrigger: input.loadTrigger,
            getItems: useCase.getFavoriteList,
            refreshTrigger: input.reloadTrigger,
            refreshItems: useCase.getFavoriteList,
            loadMoreTrigger: input.loadMoreTrigger,
            loadMoreItems: useCase.loadMoreFavoriteList)
        
        let (page, fetchItems, loadError, loading, refreshing, loadingMore) = loadMoreOutput
        
        let favoritesList = page
            .map { $0.items.map { $0 } }
            .asDriverOnErrorJustComplete()
        
        let selectedFavorites = input.selectFavoritesTrigger
            .withLatestFrom(favoritesList) { indexPath, favorites in
                return favorites[indexPath.row]
            }
            .map { (favorite) in
                return Movie(id: Int(favorite.id)!)
            }
            .do(onNext: { movie in
                self.navigator.toFavoritesDetail(movies: movie)
            })
            .mapToVoid()
        
        let isEmptyData = checkIfDataIsEmpty(fetchItemsTrigger: fetchItems,
                                             loadTrigger: Driver.merge(loading, refreshing),
                                             items: favoritesList)
        
        return Output(
            error: loadError,
            loading: loading,
            refreshing: refreshing,
            loadingMore: loadingMore,
            fetchItems: fetchItems,
            favoritesList: favoritesList,
            selectedFavorites: selectedFavorites,
            isEmptyData: isEmptyData
        )
    }
}
