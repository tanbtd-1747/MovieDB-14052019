//
//  CategoriesViewController.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

final class CategoriesViewController: UIViewController {
    deinit {
        logDeinit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

// MARK: - StotyboardSceneBased
extension CategoriesViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
