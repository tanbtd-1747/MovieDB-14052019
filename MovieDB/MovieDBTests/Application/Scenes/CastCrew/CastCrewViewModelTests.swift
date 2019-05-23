//
//  CastCrewViewModelTests.swift
//  MovieDBTests
//
//  Created by tran.duc.tan on 5/23/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking
@testable import MovieDB

final class CastCrewViewModelTests: XCTestCase {
    private var viewModel: CastCrewViewModel!
    private var navigator: CastCrewNavigatorMock!
    private var useCase: CastCrewUseCaseMock!
    
    private var input: CastCrewViewModel.Input!
    private var output: CastCrewViewModel.Output!
    
    private var disposeBag: DisposeBag!
    
    private let castCrew = CastCrew()
    
    private let loadTrigger = PublishSubject<Void>()
    private let changeListTrigger = PublishSubject<Int>()
    private let backButtonTrigger = PublishSubject<Void>()
    private let selectMovieTrigger = PublishSubject<IndexPath>()

    override func setUp() {
        super.setUp()
        navigator = CastCrewNavigatorMock()
        useCase = CastCrewUseCaseMock()
        viewModel = CastCrewViewModel(navigator: navigator, useCase: useCase, castCrew: castCrew)
        
        disposeBag = DisposeBag()
        
        input = CastCrewViewModel.Input(loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
                                        changeListTrigger: changeListTrigger.asDriverOnErrorJustComplete(),
                                        backButtonTrigger: backButtonTrigger.asDriverOnErrorJustComplete(),
                                        selectMovieTrigger: selectMovieTrigger.asDriverOnErrorJustComplete())
        output = viewModel.transform(input)
        
        output.backButtonTapped.drive().disposed(by: disposeBag)
        output.selectedMovie.drive().disposed(by: disposeBag)
        output.castCrewDetailModel.drive().disposed(by: disposeBag)
    }
    
    func test_backButtonTriggerInvoked_toMovieDetail() {
        backButtonTrigger.onNext(())
        
        XCTAssert(navigator.toMovieDetailCalled)
    }
    
    func test_whenLoadCastMovies_loadTriggerInvoked_getCastCrewDetail() {
        loadTrigger.onNext(())
        let castCrewDetail = try? output.castCrewDetailModel.toBlocking(timeout: 1).first()?.castCrewDetail
        
        XCTAssert(useCase.getCastCrewDetailCalled)
        XCTAssertEqual(castCrewDetail?.castMovies.count, 1)
    }
    
    func test_whenLoadCrewMovies_loadTriggerInvoked_getCastCrewDetail() {
        loadTrigger.onNext(())
        let castCrewDetail = try? output.castCrewDetailModel.toBlocking(timeout: 1).first()?.castCrewDetail
        
        XCTAssert(useCase.getCastCrewDetailCalled)
        XCTAssertEqual(castCrewDetail?.crewMovies.count, 1)
    }
    
    func test_whenLoadCastMovies_selectMovieTriggerInvoked_toMovieDetail() {
        loadTrigger.onNext(())
        changeListTrigger.onNext(0)
        selectMovieTrigger.onNext(IndexPath(item: 0, section: 0))
        
        XCTAssert(navigator.toMovieDetailCalledWithMovie)
    }
    
    func test_whenLoadCrewMovies_selectMovieTriggerInvoked_toMovieDetail() {
        loadTrigger.onNext(())
        changeListTrigger.onNext(1)
        selectMovieTrigger.onNext(IndexPath(item: 0, section: 0))
        
        XCTAssert(navigator.toMovieDetailCalledWithMovie)
    }
}
