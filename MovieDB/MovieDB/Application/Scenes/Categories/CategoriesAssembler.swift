//
//  CategoriesAssembler.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

protocol CategoriesAssembler {
    func resolve() -> CategoriesViewController
    func resolve() -> CategoriesViewModel
    func resolve() -> CategoriesNavigatorType
    func resolve() -> CategoriesUseCaseType
}

extension CategoriesAssembler where Self: DefaultAssembler {
    func resolve() -> CategoriesViewController {
        let viewController = CategoriesViewController.instantiate()
        let viewModel: CategoriesViewModel = resolve()
        viewController.bindViewModel(to: viewModel)
        return viewController
    }
    
    func resolve() -> CategoriesViewModel {
        return CategoriesViewModel(navigator: resolve(), useCase: resolve())
    }
    
    func resolve() -> CategoriesNavigatorType {
        return CategoriesNavigator(assembler: self)
    }
    
    func resolve() -> CategoriesUseCaseType {
        return CategoriesUseCase()
    }
}
