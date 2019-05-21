//
//  MovieDetailAssembler.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/17/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol MovieDetailAssembler {
    func resolve(navigationController: UINavigationController) -> MovieDetailViewController
    func resolve(navigationController: UINavigationController) -> MovieDetailViewModel
    func resolve(navigationController: UINavigationController) -> MovieDetailNavigatorType
    func resolve() -> MovieDetailUseCaseType
}

extension MovieDetailAssembler {
    func resolve(navigationController: UINavigationController) -> MovieDetailViewController {
        let viewController = MovieDetailViewController.instantiate()
        let viewModel: MovieDetailViewModel = resolve(navigationController: navigationController)
        viewController.bindViewModel(to: viewModel)
        return viewController
    }
    
    func resolve(navigationController: UINavigationController) -> MovieDetailViewModel {
        return MovieDetailViewModel(navigator: resolve(navigationController: navigationController),
                                    useCase: resolve())
    }
}

extension MovieDetailAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> MovieDetailNavigatorType {
        return MovieDetailNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> MovieDetailUseCaseType {
        return MovieDetailUseCase()
    }
}
