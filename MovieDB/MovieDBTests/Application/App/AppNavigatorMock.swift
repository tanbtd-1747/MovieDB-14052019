//
//  AppNavigatorMock.swift
//  MovieDBTests
//
//  Created by tran.duc.tan on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

@testable import MovieDB

final class AppNavigatorMock: AppNavigatorType {
    var toMainCalled = false
    
    func toMain() {
        toMainCalled = true
    }
}
