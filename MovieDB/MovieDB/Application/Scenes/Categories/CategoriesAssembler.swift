//
//  CategoriesAssembler.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

protocol CategoriesAssembler {
    func resolve(navigationController: UINavigationController) -> CategoriesViewController
    func resolve(navigationController: UINavigationController) -> CategoriesViewModel
    func resolve(navigationController: UINavigationController) -> CategoriesNavigatorType
    func resolve() -> CategoriesUseCaseType
}

extension CategoriesAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> CategoriesViewController {
        let viewController = CategoriesViewController.instantiate()
        let viewModel: CategoriesViewModel = resolve(navigationController: navigationController)
        viewController.bindViewModel(to: viewModel)
        return viewController
    }
    
    func resolve(navigationController: UINavigationController) -> CategoriesViewModel {
        return CategoriesViewModel(navigator: resolve(navigationController: navigationController),
                                   useCase: resolve())
    }
    
    func resolve(navigationController: UINavigationController) -> CategoriesNavigatorType {
        return CategoriesNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> CategoriesUseCaseType {
        return CategoriesUseCase(repository: resolve())
    }
}
