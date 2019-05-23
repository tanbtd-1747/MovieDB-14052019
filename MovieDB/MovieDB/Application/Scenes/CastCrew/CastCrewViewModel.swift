//
//  CastCrewViewModel.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/23/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

struct CastCrewViewModel {
    let navigator: CastCrewNavigatorType
    let useCase: CastCrewUseCaseType
    let castCrew: CastCrew
}

extension CastCrewViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let changeListTrigger: Driver<Int>
        let backButtonTrigger: Driver<Void>
        let selectMovieTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let error: Driver<Error>
        let loading: Driver<Bool>
        let castCrewDetailModel: Driver<CastCrewDetailModel>
        let moviesList: Driver<[Section<Movie>]>
        let selectedMovie: Driver<Void>
        let scrollToTop: Driver<Void>
        let isEmptyData: Driver<Bool>
        let backButtonTapped: Driver<Void>
    }
    
    func transform(_ input: CastCrewViewModel.Input) -> CastCrewViewModel.Output {
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        
        let backButtonTapped = input.backButtonTrigger
            .do(onNext: { _ in
                self.navigator.toMovieDetail()
            })
        
        let castCrewDetail = input.loadTrigger
            .flatMapLatest { _ in
                return self.useCase.getCastCrewDetail(id: self.castCrew.id)
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }
        
        let castCrewDetailModel = castCrewDetail
            .map {
                CastCrewDetailModel(castCrewDetail: $0)
            }
        
        let moviesList = Driver.combineLatest(input.changeListTrigger, castCrewDetail)
            .map { (creditTypeId, castCrewDetail) -> [Movie] in
                return creditTypeId == 0 ? castCrewDetail.castMovies : castCrewDetail.crewMovies
            }
        
        let moviesListSection = moviesList
            .map { movies in
                return [Section(items: movies)]
            }
        
        let isEmptyData = checkIfDataIsEmpty(fetchItemsTrigger: input.changeListTrigger.mapToVoid(),
                                             loadTrigger: activityIndicator.asDriver(),
                                             items: moviesList)
        
        let selectedMovie = input.selectMovieTrigger
            .withLatestFrom(moviesList) {
                return ($0, $1)
            }
            .map { indexPath, moviesList in
                return moviesList[indexPath.row]
            }
            .do(onNext: { movie in
                self.navigator.toMovieDetail(movie: movie)
            })
            .mapToVoid()
        
        return Output(error: errorTracker.asDriver(),
                      loading: activityIndicator.asDriver(),
                      castCrewDetailModel: castCrewDetailModel,
                      moviesList: moviesListSection,
                      selectedMovie: selectedMovie,
                      scrollToTop: activityIndicator.asDriver().mapToVoid(),
                      isEmptyData: isEmptyData,
                      backButtonTapped: backButtonTapped)
    }
}
