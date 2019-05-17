//
//  MoviesAssembler.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

protocol MoviesAssembler {
    func resolve(navigationController: UINavigationController) -> MoviesViewController
    func resolve(navigationController: UINavigationController) -> MoviesViewModel
    func resolve(navigationController: UINavigationController) -> MoviesNavigatorType
    func resolve() -> MoviesUseCaseType
}

extension MoviesAssembler {
    func resolve(navigationController: UINavigationController) -> MoviesViewController {
        let vc = MoviesViewController.instantiate()
        let vm: MoviesViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController) -> MoviesViewModel {
        return MoviesViewModel(navigator: resolve(navigationController: navigationController),
                               useCase: resolve())
    }
    
}

extension MoviesAssembler where Self: DefaultAssembler {
    func resolve() -> MoviesUseCaseType {
        return MoviesUseCase(repository: resolve())
    }
    
    func resolve(navigationController: UINavigationController) -> MoviesNavigatorType {
        return MoviesNavigator(assembler: self, navigationController: navigationController)
    }
}
