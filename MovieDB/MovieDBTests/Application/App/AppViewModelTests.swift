//
//  AppViewModelTests.swift
//  MovieDBTests
//
//  Created by tran.duc.tan on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking
@testable import MovieDB

final class AppViewModelTests: XCTestCase {
    private var viewModel: AppViewModel!
    private var navigator: AppNavigatorMock!
    private var useCase: AppUseCaseMock!
    
    private var input: AppViewModel.Input!
    private var output: AppViewModel.Output!
    
    private var disposeBag: DisposeBag!
    
    private let loadTrigger = PublishSubject<Void>()
    
    override func setUp() {
        super.setUp()
        navigator = AppNavigatorMock()
        useCase = AppUseCaseMock()
        viewModel = AppViewModel(navigator: navigator, useCase: useCase)
        disposeBag = DisposeBag()
        
        input = AppViewModel.Input(loadTrigger: loadTrigger.asDriverOnErrorJustComplete())
        output = viewModel.transform(input)
        
        output.toMain
            .drive()
            .disposed(by: disposeBag)
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func test_loadTriggerInvoked_toMain() {
        loadTrigger.onNext(())
        
        XCTAssert(navigator.toMainCalled)
    }
}
