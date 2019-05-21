//
//  MovieDetailViewModelTests.swift
//  MovieDBTests
//
//  Created by tran.duc.tan on 5/21/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking
@testable import MovieDB

final class MovieDetailViewModelTests: XCTestCase {
    private var viewModel: MovieDetailViewModel!
    private var navigator: MovieDetailNavigatorMock!
    private var useCase: MovieDetailUseCaseMock!
    
    private var input: MovieDetailViewModel.Input!
    private var output: MovieDetailViewModel.Output!
    
    private var disposeBag: DisposeBag!
    
    private let backButtonTrigger = PublishSubject<Void>()
    private let reviewsButtonTrigger = PublishSubject<Void>()
    private let overviewLabelTapTrigger = PublishSubject<UITapGestureRecognizer>()
    private let selectCastCrewTrigger = PublishSubject<IndexPath>()

    override func setUp() {
        super.setUp()
        navigator = MovieDetailNavigatorMock()
        useCase = MovieDetailUseCaseMock()
        viewModel = MovieDetailViewModel(navigator: navigator, useCase: useCase)
        
        disposeBag = DisposeBag()
        
        input = MovieDetailViewModel.Input(backButtonTrigger: backButtonTrigger.asDriverOnErrorJustComplete(),
                                           reviewsButtonTrigger: reviewsButtonTrigger.asDriverOnErrorJustComplete(),
                                           overviewLabelTapTrigger: overviewLabelTapTrigger
                                            .asDriverOnErrorJustComplete(),
                                           selectCastCrewTrigger: selectCastCrewTrigger.asDriverOnErrorJustComplete())
        output = viewModel.transform(input)
        
        output.backButtonTapped.drive().disposed(by: disposeBag)
        output.reviewsButtonTapped.drive().disposed(by: disposeBag)
        output.overviewLabelTapped.drive().disposed(by: disposeBag)
        output.castCrewSelected.drive().disposed(by: disposeBag)
    }
    
    func test_backButtonTriggerInvoked_toCategories() {
        backButtonTrigger.onNext(())
        
        XCTAssert(navigator.toCategoriesCalled)
    }
    
    func test_reviewsButtonTriggerInvoked_toMovieDetailReviews() {
        reviewsButtonTrigger.onNext(())
        
        XCTAssert(navigator.toMovieDetailReviewsCalled)
    }
    
    func test_overviewLabelTriggerInvoked_toMovieDetailOverview() {
        overviewLabelTapTrigger.onNext(UITapGestureRecognizer())
        
        XCTAssert(navigator.toMovieDetailOverviewCalled)
    }
    
    func test_selectCastCrewTriggerInvoked_toCastCrew() {
        selectCastCrewTrigger.onNext(IndexPath(row: 0, section: 0))
        
        XCTAssert(navigator.toCastCrewCalled)
    }
}
