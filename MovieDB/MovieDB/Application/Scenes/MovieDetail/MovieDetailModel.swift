//
//  MovieDetailModel.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/21/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

struct MovieDetailModel: Then {
    let movieDetail: MovieDetail
    
    var title: String {
        return movieDetail.title.uppercased()
    }
    
    var overview: String {
        return movieDetail.overview
    }
    
    var voteAverage: Double {
        return movieDetail.voteAverage
    }
    
    var voteAverageString: String {
        return "\(movieDetail.voteAverage)"
    }
    
    var duration: String {
        return "\(movieDetail.duration) mins"
    }
    
    var language: String {
        return movieDetail.language
    }
    
    var posterURL: URL? {
        return URL(string: API.Urls.posterUrl + movieDetail.posterPath)
    }
    
    var backdropURL: URL? {
        return URL(string: API.Urls.backdropUrl + movieDetail.backdropPath)
    }
}
