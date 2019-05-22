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
    let movie: Movie
}

extension MovieDetailViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let backButtonTrigger: Driver<Void>
        let reviewsButtonTrigger: Driver<Void>
        let overviewLabelTapTrigger: Driver<UITapGestureRecognizer>
        let playButtonTrigger: Driver<Void>
        let selectCastCrewTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let backButtonTapped: Driver<Void>
        let reviewsButtonTapped: Driver<Void>
        let overviewLabelTapped: Driver<Void>
        let playButtonTapped: Driver<Void>
        let castCrewSelected: Driver<Void>
        let movieDetailModel: Driver<MovieDetailModel>
        let error: Driver<Error>
        let isLoading: Driver<Bool>
        let castCrewList: Driver<[Section<CastCrew>]>
        let isEmptyCastCrewList: Driver<Bool>
    }
    
    func transform(_ input: MovieDetailViewModel.Input) -> MovieDetailViewModel.Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let movieDetail = input.loadTrigger
            .flatMapLatest { _ in
                return self.useCase.getMovieDetail(id: self.movie.id)
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }
        
        let backButtonTapped = input.backButtonTrigger
            .do(onNext: { _ in
                self.navigator.toCategories()
            })
        
        let reviewsButtonTapped = input.reviewsButtonTrigger
            .withLatestFrom(movieDetail)
            .do(onNext: { movieDetail in
                self.navigator.toMovieDetailReviews(movieDetail: movieDetail)
            })
            .mapToVoid()
        
        let overviewLabelTapped = input.overviewLabelTapTrigger
            .withLatestFrom(movieDetail)
            .do(onNext: { movieDetail in
                self.navigator.toMovieDetailOverview(movieDetail: movieDetail)
            })
            .mapToVoid()
        
        let playButtonTapped = input.playButtonTrigger
            .withLatestFrom(movieDetail)
            .do(onNext: { movieDetail in
                self.navigator.toVideo(movieDetail: movieDetail)
            })
            .mapToVoid()
        
        let movieDetailModel = movieDetail
            .map {
                MovieDetailModel(movieDetail: $0)
            }
        
        let castCrewSelected = input.selectCastCrewTrigger
            .do(onNext: { _ in
                self.navigator.toCastCrew()
            })
            .mapToVoid()
        
        let castCrewList = movieDetail
            .map {
                ($0.casts + $0.crews).filter { castCrew in
                    return !castCrew.profilePath.isEmpty
                }
            }
            .map { castCrew in
                return [Section<CastCrew>(items: castCrew)]
            }
        
        let isEmptyCastCrewList = checkIfDataIsEmpty(fetchItemsTrigger: input.loadTrigger,
                                                     loadTrigger: activityIndicator.asDriver(),
                                                     items: castCrewList)
        
        return Output(
            backButtonTapped: backButtonTapped,
            reviewsButtonTapped: reviewsButtonTapped,
            overviewLabelTapped: overviewLabelTapped,
            playButtonTapped: playButtonTapped,
            castCrewSelected: castCrewSelected,
            movieDetailModel: movieDetailModel,
            error: errorTracker.asDriver(),
            isLoading: activityIndicator.asDriver(),
            castCrewList: castCrewList,
            isEmptyCastCrewList: isEmptyCastCrewList
        )
    }
}
