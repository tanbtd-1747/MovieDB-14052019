//
//  CastCrewNavigator.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/23/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol CastCrewNavigatorType {
    
}

struct CastCrewNavigator: CastCrewNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
