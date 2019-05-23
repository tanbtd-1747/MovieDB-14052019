//
//  FavoritesUseCase.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/22/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol FavoritesUseCaseType {
    func getFavoriteList() -> Observable<PagingInfo<Favorite>>
    func loadMoreFavoriteList(page: Int) -> Observable<PagingInfo<Favorite>>
}

struct FavoriteUseCase: FavoritesUseCaseType {
    let favoriteRepository: FavoriteRepositoryType
    
    func getFavoriteList() -> Observable<PagingInfo<Favorite>> {
        return favoriteRepository
            .getFavorites()
            .map { PagingInfo(page: 1, items: $0) }
    }
    
    func loadMoreFavoriteList(page: Int) -> Observable<PagingInfo<Favorite>> {
        return Observable.empty()
    }
}
