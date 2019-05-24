//
//  Favorite.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/22/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

struct Favorite {
    var id: String
    var title: String
    var posterPath: String
}

extension Favorite {
    init() {
        self.init(
            id: "",
            title: "",
            posterPath: ""
        )
    }
}

// MARK: - CoreDataModel
extension Favorite: CoreDataModel {
    static var primaryKey: String {
        return "id"
    }
    
    var modelID: String {
        return id
    }
}
