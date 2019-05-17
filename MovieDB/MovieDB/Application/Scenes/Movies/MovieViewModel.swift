//
//  MovieViewModel.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/17/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

struct MovieViewModel {
    let movie: Movie
    
    var title: String {
        return movie.title
    }
    var backdropPath: String {
        return movie.backdropPath
    }
    var posterPath: String {
        return movie.posterPath
    }
}
