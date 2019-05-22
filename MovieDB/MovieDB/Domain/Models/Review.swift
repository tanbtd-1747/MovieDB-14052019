//
//  Review.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/21/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import ObjectMapper

struct Review {
    var id: String
    var author: String
    var content: String
}

extension Review {
    init() {
        self.init(id: "",
                  author: "",
                  content: "")
    }
}

extension Review: Then { }

extension Review: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        author <- map["author"]
        content <- map["content"]
    }
}
