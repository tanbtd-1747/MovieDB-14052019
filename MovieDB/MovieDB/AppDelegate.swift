//
//  AppDelegate.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var assembler: Assembler = DefaultAssembler()
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        if NSClassFromString("XCTest") != nil {
            window?.rootViewController = UnitTestViewController()
        } else {
            bindViewModel()
        }
    }
    
    private func bindViewModel() {
        guard let window = window else {
            return
        }
        
        let viewModel: AppViewModel = assembler.resolve(window: window)
        let input = AppViewModel.Input(loadTrigger: Driver.just(()))
        let output = viewModel.transform(input)
        
        output.toMain
            .drive()
            .disposed(by: rx.disposeBag)
    }
}
