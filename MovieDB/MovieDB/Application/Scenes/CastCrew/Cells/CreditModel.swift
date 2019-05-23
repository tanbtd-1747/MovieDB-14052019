//
//  CreditModel.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/23/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

struct CreditModel: Then {
    let movie: Movie
    
    var posterURL: URL? {
        return URL(string: API.Urls.posterUrl + movie.posterPath)
    }
}
