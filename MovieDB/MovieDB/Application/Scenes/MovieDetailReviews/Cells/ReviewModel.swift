//
//  ReviewModel.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/21/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

struct ReviewModel: Then {
    let review: Review
    
    var author: String {
        return review.author
    }
    
    var content: String {
        return review.content
    }
    
    var avatarURL: URL? {
        return URL(string: API.Urls.avatarUrl + review.id + ".jpg")
    }
}
