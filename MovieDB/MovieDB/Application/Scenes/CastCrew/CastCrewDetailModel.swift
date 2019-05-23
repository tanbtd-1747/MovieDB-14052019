//
//  CastCrewDetailModel.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/23/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

struct CastCrewDetailModel: Then {
    let castCrewDetail: CastCrewDetail
    
    var name: String {
        return castCrewDetail.name
    }
    
    var profileURL: URL? {
        return URL(string: API.Urls.profileUrl + castCrewDetail.profile)
    }
}
