//
//  VideoViewController.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/22/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

final class VideoViewController: UIViewController, BindableType {
    @IBOutlet weak var sheetView: UIView!
    @IBOutlet weak var videoPlayerView: WKYTPlayerView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    var viewModel: VideoViewModel!
    
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
        sheetView.makeRounded()
    }
    
    func bindViewModel() {
        view.rx.swipeGesture(SwipeDirection.up)
            .when(.ended)
            .asDriverOnErrorJustComplete()
            .drive(onNext: { [weak self] _ in
                self?.dismissTopSheetViewController()
            })
            .disposed(by: rx.disposeBag)
        
        let input = VideoViewModel.Input(loadTrigger: Driver.just(()))
        let output = viewModel.transform(input)
        
        output.video
            .drive(model)
            .disposed(by: rx.disposeBag)
    }
}

extension VideoViewController {
    var model: Binder<Video> {
        return Binder(self) { viewController, video in
            viewController.do {
                $0.videoTitleLabel.text = video.name
                $0.videoPlayerView.load(withVideoId: video.key)
            }
        }
    }
}

// MARK: - StotyboardSceneBased
extension VideoViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.movieDetail
}
