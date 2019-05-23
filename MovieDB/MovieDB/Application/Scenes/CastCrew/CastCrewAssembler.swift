//
//  CastCrewAssembler.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/21/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol CastCrewAssembler {
    func resolve(navigationController: UINavigationController) -> CastCrewViewController
    func resolve(navigationController: UINavigationController) -> CastCrewViewModel
    func resolve(navigationController: UINavigationController) -> CastCrewNavigatorType
    func resolve() -> CastCrewUseCaseType
}

extension CastCrewAssembler {
    func resolve(navigationController: UINavigationController) -> CastCrewViewController {
        let viewController = CastCrewViewController.instantiate()
        let viewModel: CastCrewViewModel = resolve(navigationController: navigationController)
        viewController.bindViewModel(to: viewModel)
        return viewController
    }
    
    func resolve(navigationController: UINavigationController) -> CastCrewViewModel {
        return CastCrewViewModel(navigator: resolve(navigationController: navigationController),
                                 useCase: resolve())
    }
}

extension CastCrewAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> CastCrewNavigatorType {
        return CastCrewNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> CastCrewUseCaseType {
        return CastCrewUseCase()
    }
}
