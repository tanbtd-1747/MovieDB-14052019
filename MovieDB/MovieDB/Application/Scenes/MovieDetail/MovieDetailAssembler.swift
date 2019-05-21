//
//  MovieDetailAssembler.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/17/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol MovieDetailAssembler {
    func resolve(navigationController: UINavigationController, movie: Movie) -> MovieDetailViewController
    func resolve(navigationController: UINavigationController, movie: Movie) -> MovieDetailViewModel
    func resolve(navigationController: UINavigationController) -> MovieDetailNavigatorType
    func resolve() -> MovieDetailUseCaseType
}

extension MovieDetailAssembler {
    func resolve(navigationController: UINavigationController, movie: Movie) -> MovieDetailViewController {
        let viewController = MovieDetailViewController.instantiate()
        let viewModel: MovieDetailViewModel = resolve(navigationController: navigationController, movie: movie)
        viewController.bindViewModel(to: viewModel)
        return viewController
    }
    
    func resolve(navigationController: UINavigationController, movie: Movie) -> MovieDetailViewModel {
        return MovieDetailViewModel(navigator: resolve(navigationController: navigationController),
                                    useCase: resolve(),
                                    movie: movie)
    }
}

extension MovieDetailAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> MovieDetailNavigatorType {
        return MovieDetailNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> MovieDetailUseCaseType {
        return MovieDetailUseCase(repository: resolve())
    }
}
