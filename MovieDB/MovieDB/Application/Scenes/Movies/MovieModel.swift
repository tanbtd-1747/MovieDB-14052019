//
//  MovieModel.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/17/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

struct MovieModel: Then {
    let movie: Movie
    
    var title: String {
        return movie.title.uppercased()
    }
    
    var overview: String {
        return movie.overview
    }
    
    var backdropURL: URL? {
        return URL(string: API.Urls.backdropUrl + movie.backdropPath)
    }
    
    var posterURL: URL? {
        return URL(string: API.Urls.posterUrl + movie.posterPath)
    }
    
    var voteProgress: Float {
        return Float(movie.voteAverage / 10)
    }
    
    var vote: String {
        return "\(movie.voteAverage)"
    }
    
    var voteTextColor: UIColor {
        switch movie.voteAverage {
        case 0..<4.0:
            return .pastelRed
        case 4.0..<7.0:
            return .burlywood
        case 7.0...10.0:
            return .pearlAqua
        default:
            return .white
        }
    }
    
    var isVoteHidden: Bool {
        return movie.voteAverage > 0.0 ? false : true
    }
    
    var releaseDate: String {
        return String(movie.releaseDate.releaseDateString)
    }
}
