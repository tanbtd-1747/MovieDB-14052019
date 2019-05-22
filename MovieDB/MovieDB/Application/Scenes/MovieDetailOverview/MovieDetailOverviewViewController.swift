//
//  MovieDetailOverviewViewController.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/20/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

final class MovieDetailOverviewViewController: UIViewController, BindableType {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    var viewModel: MovieDetailOverviewViewModel!
    
    deinit {
        logDeinit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentSheetViewController()
    }
    
    private func configSubviews() {
        containerView.makeRoundedAndShadowed()
    }
    
    func bindViewModel() {
        closeButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.dismissSheetViewController()
            })
            .disposed(by: rx.disposeBag)
        
        let input = MovieDetailOverviewViewModel.Input(loadTrigger: Driver.just(()))
        let output = viewModel.transform(input)
        
        output.overview
            .drive(movieOverviewLabel.rx.text)
            .disposed(by: rx.disposeBag)
    }
}

// MARK: - StotyboardSceneBased
extension MovieDetailOverviewViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.movieDetail
}
