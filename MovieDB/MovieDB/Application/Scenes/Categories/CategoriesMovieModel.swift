//
//  CategoriesMovieModel.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/16/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

struct CategoriesMovieModel: Then {
    let movie: Movie
    
    var title: String {
        return movie.title.uppercased()
    }
    
    var year: String {
        return String(movie.releaseDate.releaseDateString.prefix(4))
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
    
    var posterURL: URL? {
        return URL(string: API.Urls.posterUrl + movie.posterPath)
    }
}
