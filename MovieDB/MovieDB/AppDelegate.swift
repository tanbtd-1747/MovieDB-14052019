//
//  AppDelegate.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit
import MagicalRecord

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var assembler: Assembler = DefaultAssembler()
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        setupCoreData()
        
        if NSClassFromString("XCTest") != nil {
            window?.rootViewController = UnitTestViewController()
        } else {
            bindViewModel()
        }
    }
    
    private func setupCoreData() {
        MagicalRecord.setupAutoMigratingCoreDataStack()
        MagicalRecord.setLoggingLevel(MagicalRecordLoggingLevel.error)
    }
    
    private func bindViewModel() {
        window = UIWindow()
        if let window = window {
            let viewModel: AppViewModel = assembler.resolve(window: window)
            let input = AppViewModel.Input(loadTrigger: Driver.just(()))
            let output = viewModel.transform(input)
            
            output.toMain
                .drive()
                .disposed(by: rx.disposeBag)
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        MagicalRecord.cleanUp()
    }
}
