//
//  CastCrewAssembler.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/21/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol CastCrewAssembler {
    func resolve() -> CastCrewViewController
}

extension CastCrewAssembler {
    func resolve() -> CastCrewViewController {
        let viewController = CastCrewViewController.instantiate()
        return viewController
    }
}
