//
//  MovieDetailReviewsViewModel.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/20/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

struct MovieDetailReviewsViewModel {
    let movieDetail: MovieDetail
}

extension MovieDetailReviewsViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let reviewsList: Driver<[Review]>
        let isEmptyReviewsList: Driver<Bool>
    }
    
    func transform(_ input: MovieDetailReviewsViewModel.Input) -> MovieDetailReviewsViewModel.Output {
        let reviewsList = input.loadTrigger
            .map {
                self.movieDetail.reviews
            }
        
        let isEmptyReviewsList = checkIfDataIsEmpty(fetchItemsTrigger: input.loadTrigger,
                                                    loadTrigger: Driver.just(false),
                                                    items: reviewsList)
        
        return Output(
            reviewsList: reviewsList,
            isEmptyReviewsList: isEmptyReviewsList
        )
    }
}
