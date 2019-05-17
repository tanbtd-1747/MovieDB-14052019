//
//  RepositoriesAssembler.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import Foundation

import UIKit

protocol RepositoriesAssembler {
    func resolve() -> MovieRepositoryType
}

extension RepositoriesAssembler where Self: DefaultAssembler {
    func resolve() -> MovieRepositoryType {
        return MovieRepository()
    }
}