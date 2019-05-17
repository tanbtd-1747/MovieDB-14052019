//
//  MovieDetailViewController.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/17/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    deinit {
        logDeinit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - StotyboardSceneBased
extension MovieDetailViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.movieDetail
}
