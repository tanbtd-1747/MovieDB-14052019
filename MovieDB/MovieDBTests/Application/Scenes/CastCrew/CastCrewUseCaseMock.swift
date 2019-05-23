//
//  CastCrewUseCaseMock.swift
//  MovieDBTests
//
//  Created by tran.duc.tan on 5/23/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import RxSwift
@testable import MovieDB

final class CastCrewUseCaseMock: CastCrewUseCaseType {
    var getCastCrewDetailCalled = false
    
    var getCastCrewDetailReturnValue: Observable<CastCrewDetail> {
        var castCrewDetail = CastCrewDetail()
        castCrewDetail.castMovies = [Movie()]
        castCrewDetail.crewMovies = [Movie()]
        
        return Observable.just(castCrewDetail)
    }
    
    func getCastCrewDetail(id: Int) -> Observable<CastCrewDetail> {
        getCastCrewDetailCalled = true
        return getCastCrewDetailReturnValue
    }
}
