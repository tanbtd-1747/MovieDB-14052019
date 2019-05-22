//
//  Video.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/21/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import ObjectMapper

struct Video {
    var id: String
    var key: String
    var name: String
    var site: String
    var type: String
}

extension Video {
    init() {
        self.init(id: "",
                  key: "",
                  name: "",
                  site: "",
                  type: "")
    }
}

extension Video: Then { }

extension Video: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        key <- map["key"]
        name <- map["name"]
        site <- map["site"]
        type <- map["type"]
    }
}
