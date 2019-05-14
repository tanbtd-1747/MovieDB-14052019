//
//  MainViewController.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

final class MainViewController: RAMAnimatedTabBarController {
    deinit {
        logDeinit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.do {
            $0.backgroundImage = UIImage()
            $0.shadowImage = UIImage()
            $0.backgroundColor = .ghostWhite
        }
    }
}

// MARK: - StotyboardSceneBased
extension MainViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
