//
//  CategoriesViewModel.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/15/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

struct CategoriesViewModel {
    let navigator: CategoriesNavigatorType
    let useCase: CategoriesUseCaseType
}

extension CategoriesViewModel: ViewModelType {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(_ input: CategoriesViewModel.Input) -> CategoriesViewModel.Output {
        return Output()
    }
}
