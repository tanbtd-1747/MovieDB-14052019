//
//  RepositoriesAssembler.swift
//  MovieDB
//  Created by pham.van.ducd on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import Foundation
import UIKit

protocol RepositoriesAssembler {
    func resolve() -> MovieRepositoryType
    func resolve() -> SearchRepositoryType
    func resolve() -> MovieDetailRepositoryType
    func resolve() -> CastCrewDetailRepositoryType
    func resolve() -> FavoriteRepositoryType
}

extension RepositoriesAssembler where Self: DefaultAssembler {
    func resolve() -> MovieRepositoryType {
        return MovieRepository()
    }
    
    func resolve() -> SearchRepositoryType {
        return SearchRepository()
    }

    func resolve() -> MovieDetailRepositoryType {
        return MovieDetailRepository()
    }
    
    func resolve() -> CastCrewDetailRepositoryType {
        return CastCrewDetailRepository()
    }
    
    func resolve() -> FavoriteRepositoryType {
        return FavoriteRepository()
    }
}
