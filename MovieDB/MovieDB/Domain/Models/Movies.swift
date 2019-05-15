//
//  Movies.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import Foundation
import ObjectMapper

struct Movie {
    var id: Int
    var title: String
    var genres: [String]
    var genreIds: [Int]
    var overview: String
    var posterPath: String
    var backdropPath: String
    var releaseDate: Date
    var voteAverage: Double
}

extension Movie {
    init() {
        self.init(
            id: 0,
            title: "",
            genres: [],
            genreIds: [],
            overview: "",
            posterPath: "",
            backdropPath: "",
            releaseDate: Date(),
            voteAverage: 0
        )
    }
}

extension Movie: Mappable {
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        let realeaseTransform = DateFormatterTransform(dateFormatter: Date.Formatter.realeaseDate.instance)
        id <- map["id"]
        title <- map["title"]
        genres <- map["genres"]
        genreIds <- map["genreIds"]
        overview <- map["overview"]
        posterPath <- map["poster_path"]
        backdropPath <- map["backdrop_path"]
        releaseDate <- (map["release_date"], realeaseTransform)
        voteAverage <- map["vote_average"]
    }
}
