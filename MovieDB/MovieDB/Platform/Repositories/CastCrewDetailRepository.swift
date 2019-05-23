//
//  CastCrewDetailRepository.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/23/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol CastCrewDetailRepositoryType {
    func getCastCrewDetail(id: Int) -> Observable<CastCrewDetail>
}

final class CastCrewDetailRepository: CastCrewDetailRepositoryType {
    func getCastCrewDetail(id: Int) -> Observable<CastCrewDetail> {
        let input = API.GetCastCrewDetailInput(id: id)
        return API.shared.getCastCrewDetail(input)
    }
}
