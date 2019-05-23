//
//  CastCrewAssembler.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/21/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol CastCrewAssembler {
    func resolve(navigationController: UINavigationController, castCrew: CastCrew) -> CastCrewViewController
    func resolve(navigationController: UINavigationController, castCrew: CastCrew) -> CastCrewViewModel
    func resolve(navigationController: UINavigationController) -> CastCrewNavigatorType
    func resolve() -> CastCrewUseCaseType
}

extension CastCrewAssembler {
    func resolve(navigationController: UINavigationController, castCrew: CastCrew) -> CastCrewViewController {
        let viewController = CastCrewViewController.instantiate()
        let viewModel: CastCrewViewModel = resolve(navigationController: navigationController, castCrew: castCrew)
        viewController.bindViewModel(to: viewModel)
        return viewController
    }
    
    func resolve(navigationController: UINavigationController, castCrew: CastCrew) -> CastCrewViewModel {
        return CastCrewViewModel(navigator: resolve(navigationController: navigationController),
                                 useCase: resolve(),
                                 castCrew: castCrew)
    }
}

extension CastCrewAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> CastCrewNavigatorType {
        return CastCrewNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> CastCrewUseCaseType {
        return CastCrewUseCase(repository: resolve())
    }
}
