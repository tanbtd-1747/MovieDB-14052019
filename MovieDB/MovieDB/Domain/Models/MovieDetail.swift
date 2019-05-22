//
//  MovieDetail.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/21/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import ObjectMapper

struct MovieDetail {
    var id: Int
    var title: String
    var overview: String
    var language: String
    var duration: Int
    var posterPath: String
    var backdropPath: String
    var voteAverage: Double
    var videos: [Video]
    var casts: [CastCrew]
    var crews: [CastCrew]
    var reviews: [Review]
}

extension MovieDetail {
    init() {
        self.init(id: 0,
                  title: "",
                  overview: "",
                  language: "",
                  duration: 0,
                  posterPath: "",
                  backdropPath: "",
                  voteAverage: 0.0,
                  videos: [],
                  casts: [],
                  crews: [],
                  reviews: [])
    }
}

extension MovieDetail: Then { }

extension MovieDetail: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["original_title"]
        overview <- map["overview"]
        language <- map["original_language"]
        duration <- map["runtime"]
        posterPath <- map["poster_path"]
        backdropPath <- map["backdrop_path"]
        voteAverage <- map["vote_average"]
        videos <- map["videos.results"]
        casts <- map["credits.cast"]
        crews <- map["credits.crew"]
        reviews <- map["reviews.results"]
    }
}
