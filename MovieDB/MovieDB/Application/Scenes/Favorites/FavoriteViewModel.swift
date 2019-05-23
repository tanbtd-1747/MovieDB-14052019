//
//  FavoriteViewModel.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/22/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

struct FavoriteViewModel {
    let favorite: Favorite
    
    var title: String {
        return favorite.title
    }
    
    var posterPath: String! {
        return favorite.posterPath
    }
}

