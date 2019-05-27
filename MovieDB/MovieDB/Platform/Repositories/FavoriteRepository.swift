//
//  FavoriteRepository.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/22/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import MagicalRecord

protocol FavoriteRepositoryType {
    func getFavorites() -> Observable<[Favorite]>
    func add(_ favorite: [Favorite]) -> Observable<Void>
}

struct FavoriteRepository: FavoriteRepositoryType {
    func getFavorites() -> Observable<[Favorite]> {
        return all()
    }
    
    func add(_ favorite: [Favorite]) -> Observable<Void> {
        return addAll(favorite)
    }
}

extension FavoriteRepository: CoreDataRepository {
    static func map(from item: Favorite, to entity: FavoriteEntity) {
        entity.id = item.id
        entity.title = item.title
        entity.posterPath = item.posterPath
    }
    
    static func item(from entity: FavoriteEntity) -> Favorite? {
        guard let id = entity.id else { return nil }
        return Favorite(
            id: id,
            title: entity.title ?? "",
            posterPath: entity.posterPath ?? ""
        )
    }
}
