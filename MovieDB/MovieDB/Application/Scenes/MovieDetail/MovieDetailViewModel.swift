//
//  MovieDetailViewModel.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/20/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

struct MovieDetailViewModel {
    let navigator: MovieDetailNavigatorType
    let useCase: MovieDetailUseCaseType
}

extension MovieDetailViewModel: ViewModelType {
    struct Input {
        let backButtonTrigger: Driver<Void>
        let reviewsButtonTrigger: Driver<Void>
        let overviewLabelTrigger: Driver<UITapGestureRecognizer>
        let selectCastCrewTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let backButtonTapped: Driver<Void>
        let reviewsButtonTapped: Driver<Void>
        let overviewLabelTapped: Driver<Void>
        let castCrewSelected: Driver<Void>
    }
    
    func transform(_ input: MovieDetailViewModel.Input) -> MovieDetailViewModel.Output {
        let backButtonTapped = input.backButtonTrigger
            .do(onNext: { _ in
                self.navigator.toCategories()
            })
        
        let reviewsButtonTapped = input.reviewsButtonTrigger
            .do(onNext: { _ in
                self.navigator.toMovieDetailReviews()
            })
        
        let overviewLabelTapped = input.overviewLabelTrigger
            .do(onNext: { _ in
                self.navigator.toMovieDetailOverview()
            })
            .mapToVoid()
        
        let castCrewSelected = input.selectCastCrewTrigger
            .do(onNext: { _ in
                self.navigator.toCastCrew()
            })
            .mapToVoid()
        
        return Output(
            backButtonTapped: backButtonTapped,
            reviewsButtonTapped: reviewsButtonTapped,
            overviewLabelTapped: overviewLabelTapped,
            castCrewSelected: castCrewSelected
        )
    }
}
