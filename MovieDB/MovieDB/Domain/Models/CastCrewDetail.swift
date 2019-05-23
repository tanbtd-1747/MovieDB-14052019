//
//  CastCrewDetail.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/23/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import ObjectMapper

struct CastCrewDetail {
    var id: Int
    var name: String
    var profile: String
    var castMovies: [Movie]
    var crewMovies: [Movie]
}

extension CastCrewDetail {
    init() {
        self.init(id: 0,
                  name: "",
                  profile: "",
                  castMovies: [],
                  crewMovies: [])
    }
}

extension CastCrewDetail: Then { }

extension CastCrewDetail: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        profile <- map["profile_path"]
        castMovies <- map["combined_credits.cast"]
        crewMovies <- map["combined_credits.crew"]
    }
}
