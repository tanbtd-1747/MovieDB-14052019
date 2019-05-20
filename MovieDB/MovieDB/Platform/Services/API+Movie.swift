//
//  API+Movie.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/16/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import ObjectMapper

extension API {
    func getMoviesList(_ input: GetMoviesListInput) -> Observable<GetMoviesListOutput> {
        return request(input)
    }
}

// MARK: - GetMoviesList
extension API {
    final class GetMoviesListInput: APIInput {
        init(category: CategoryType, page: Int) {
            let params: JSONDictionary = [
                "api_key": Keys.key,
                "language": "en-US",
                "page": page
            ]
            super.init(urlString: API.Urls.moviesListURL + category.rawValue,
                       parameters: params,
                       requestType: .get,
                       requireAccessToken: false)
        }
    }
    
    final class GetMoviesListOutput: APIOutput {
        private(set) var movies: [Movie]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            movies <- map["results"]
        }
    }
}
