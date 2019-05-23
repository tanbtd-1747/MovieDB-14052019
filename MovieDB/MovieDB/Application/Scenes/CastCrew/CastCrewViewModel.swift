//
//  CastCrewViewModel.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/23/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

struct CastCrewViewModel {
    let navigator: CastCrewNavigatorType
    let useCase: CastCrewUseCaseType
}

extension CastCrewViewModel: ViewModelType {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(_ input: CastCrewViewModel.Input) -> CastCrewViewModel.Output {
        return Output()
    }
}
