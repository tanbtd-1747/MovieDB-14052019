//
//  SearchViewModel.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/17/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

struct SearchViewModel {
    let navigator: SearchNavigatorType
    let useCase: SearchUseCaseType
}

// MARK: - ViewModelType
extension SearchViewModel: ViewModelType {
    
    struct Input {
        let editTrigger: Driver<String>
        let selectedTrigger: Driver<IndexPath>
        let rejectTrigger: Driver<Void>
        let selectMovieTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let movies: Driver<[Movie]>
        let reject: Driver<Void>
        let error: Driver<Error>
        let loading: Driver<Bool>
        let selectedMovie: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        
        let reject = input.rejectTrigger
            .do(onNext: { (_) in
               self.navigator.toCancel()
            })
            .mapToVoid()
        
        let movies = input.editTrigger
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .flatMapLatest { keyword -> Driver<[Movie]> in
                return self.useCase.getSearchList(page: 1, searchText: keyword)
                    .trackError(errorTracker)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
        
        let selectedMovie = input.selectMovieTrigger
            .withLatestFrom(movies) {
                return ($0, $1)
            }
            .map { indexPath, moviesList in
                return moviesList[indexPath.row]
            }
            .do(onNext: { movie in
                self.navigator.toMovieDetail(movie: movie)
            })
            .mapToVoid()
        
        return Output(movies: movies,
                      reject: reject,
                      error: errorTracker.asDriver(),
                      loading: activityIndicator.asDriver(),
                      selectedMovie: selectedMovie)
    }
}

