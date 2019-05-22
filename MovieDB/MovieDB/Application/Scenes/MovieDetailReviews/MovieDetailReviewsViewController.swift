//
//  MovieDetailReviewsViewController.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/20/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

final class MovieDetailReviewsViewController: UIViewController, BindableType {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var reviewsTableView: UITableView!
    @IBOutlet weak var closeButton: UIButton!
    
    var viewModel: MovieDetailReviewsViewModel!
    
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
        
        reviewsTableView.do {
            $0.register(cellType: ReviewTableViewCell.self)
            $0.rowHeight = UITableView.automaticDimension
            $0.estimatedRowHeight = 100
        }
    }
    
    func bindViewModel() {
        closeButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.dismissSheetViewController()
            })
            .disposed(by: rx.disposeBag)
        
        let input = MovieDetailReviewsViewModel.Input(loadTrigger: Driver.just(()))
        let output = viewModel.transform(input)
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section<Review>>(
            configureCell: { _, tableView, indexPath, review in
                let cell = tableView.dequeueReusableCell(for: indexPath,
                                                         cellType: ReviewTableViewCell.self)
                    .then {
                        $0.bindModel(ReviewModel(review: review))
                    }
                return cell
            })
        
        output.reviewsListSection
            .drive(reviewsTableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        output.isEmptyReviewsList
            .drive(reviewsTableView.rx.isEmptyData)
            .disposed(by: rx.disposeBag)
    }
}

// MARK: - StotyboardSceneBased
extension MovieDetailReviewsViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.movieDetail
}
