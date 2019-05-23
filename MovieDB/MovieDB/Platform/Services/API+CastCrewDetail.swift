//
//  API+CastCrewDetail.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/23/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import ObjectMapper

extension API {
    func getCastCrewDetail(_ input: GetCastCrewDetailInput) -> Observable<CastCrewDetail> {
        return request(input)
    }
}

// MARK: - GetCastCrewDetail
extension API {
    final class GetCastCrewDetailInput: APIInput {
        init(id: Int) {
            let params: JSONDictionary = [
                "api_key": Keys.key,
                "language": "en-US",
                "append_to_response": "combined_credits"
            ]
            super.init(
                urlString: API.Urls.personURL + "\(id)",
                parameters: params,
                requestType: .get,
                requireAccessToken: false
            )
        }
    }
}
