//
//  CastCrewModel.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/21/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

struct CastCrewModel: Then {
    let castCrew: CastCrew
    
    var name: String {
        return castCrew.name
    }
    
    var profileURL: URL? {
        return URL(string: API.Urls.profileUrl + castCrew.profilePath)
    }
}
