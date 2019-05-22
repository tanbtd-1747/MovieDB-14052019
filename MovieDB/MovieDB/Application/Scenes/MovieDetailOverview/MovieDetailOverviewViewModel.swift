//
//  MovieDetailOverviewViewModel.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/21/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

struct MovieDetailOverviewViewModel {
    let movieDetail: MovieDetail
}

extension MovieDetailOverviewViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let overview: Driver<String>
    }
    
    func transform(_ input: MovieDetailOverviewViewModel.Input) -> MovieDetailOverviewViewModel.Output {
        let overview = input.loadTrigger
            .map {
                self.movieDetail.overview
            }
        
        return Output(
            overview: overview
        )
    }
}
