//
//  CastCrew.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/21/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import ObjectMapper

struct CastCrew {
    var id: Int
    var name: String
    var profilePath: String
}

extension CastCrew {
    init() {
        self.init(id: 0,
                  name: "",
                  profilePath: "")
    }
}

extension CastCrew: Then { }

extension CastCrew: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        profilePath <- map["profile_path"]
    }
}
