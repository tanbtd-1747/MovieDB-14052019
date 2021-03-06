//
//  CastCrewUseCase.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/23/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol CastCrewUseCaseType {
    func getCastCrewDetail(id: Int) -> Observable<CastCrewDetail>
}

struct CastCrewUseCase: CastCrewUseCaseType {
    let repository: CastCrewDetailRepositoryType
    
    func getCastCrewDetail(id: Int) -> Observable<CastCrewDetail> {
        return repository.getCastCrewDetail(id: id)
    }
}
