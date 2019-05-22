//
//  API+MovieDetail.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/21/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import ObjectMapper

extension API {
    func getMovieDetail(_ input: GetMovieDetailInput) -> Observable<MovieDetail> {
        return request(input)
    }
}

// MARK: - GetMovieDetail
extension API {
    final class GetMovieDetailInput: APIInput {
        init(id: Int) {
            let params: JSONDictionary = [
                "api_key": Keys.key,
                "language": "en-US",
                "append_to_response": "videos,credits,reviews"
            ]
            super.init(urlString: API.Urls.moviesListURL + "\(id)",
                       parameters: params,
                       requestType: .get,
                       requireAccessToken: false)
        }
    }
}
