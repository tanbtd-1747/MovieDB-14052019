//
//  FavoritesAssembler.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

protocol FavoritesAssembler {
    func resolve(navigationController: UINavigationController) -> FavoritesViewController
    func resolve(navigationController: UINavigationController) -> FavoritesViewModel
    func resolve(navigationController: UINavigationController) -> FavoritesNavigatorType
    func resolve() -> FavoritesUseCaseType
}

extension FavoritesAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> FavoritesViewController {
        let viewController = FavoritesViewController.instantiate()
        let vm: FavoritesViewModel = resolve(navigationController: navigationController)
        viewController.bindViewModel(to: vm)
        return viewController
    }
    
    func resolve(navigationController: UINavigationController) -> FavoritesViewModel {
        return FavoritesViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
    
    func resolve(navigationController: UINavigationController) -> FavoritesNavigatorType {
        return FavoritesListNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> FavoritesUseCaseType {
        return FavoriteUseCase(favoriteRepository: resolve())
    }
}
