//
//  MovieDetailViewController.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/17/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit
import Cosmos
import SDWebImage

final class MovieDetailViewController: UIViewController, BindableType {
    @IBOutlet weak var movieBackdropImageView: UIImageView!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingView: CosmosView!
    @IBOutlet weak var movieLanguageLabel: UILabel!
    @IBOutlet weak var movieDurationLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var movieCastCrewCollectionView: UICollectionView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var reviewsButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    let layoutOption = LayoutOption()
    
    var viewModel: MovieDetailViewModel!
    
    deinit {
        logDeinit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideTabBar(true)
    }
    
    private func configSubviews() {
        moviePosterImageView.makeRoundedAndShadowed()
        backButton.makeRoundedAndShadowed()
        playButton.makeRounded(radius: playButton.frame.height / 2)
        favoriteButton.makeRoundedAndShadowed(cornerRadius: favoriteButton.frame.height / 2)
        reviewsButton.makeRoundedAndShadowed(cornerRadius: reviewsButton.frame.height / 2)
        
        movieCastCrewCollectionView.do {
            $0.register(cellType: CastCrewCollectionViewCell.self)
            $0.delegate = self
        }
    }
    
    func bindViewModel() {
        let input = MovieDetailViewModel.Input(
            loadTrigger: Driver.just(()),
            backButtonTrigger: backButton.rx.tap.asDriver(),
            reviewsButtonTrigger: reviewsButton.rx.tap.asDriver(),
            overviewLabelTapTrigger: movieOverviewLabel.rx.tapGesture().when(.recognized).asDriverOnErrorJustComplete(),
            selectCastCrewTrigger: movieCastCrewCollectionView.rx.itemSelected.asDriver()
        )
        let output = viewModel.transform(input)
        
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        output.isLoading
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
        output.backButtonTapped
            .drive()
            .disposed(by: rx.disposeBag)
        output.reviewsButtonTapped
            .drive()
            .disposed(by: rx.disposeBag)
        output.overviewLabelTapped
            .drive()
            .disposed(by: rx.disposeBag)
        output.castCrewSelected
            .drive()
            .disposed(by: rx.disposeBag)
        output.movieDetailModel
            .drive(model)
            .disposed(by: rx.disposeBag)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<Section<CastCrew>>(
            configureCell: { _, collectionView, indexPath, castCrew in
                let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                              cellType: CastCrewCollectionViewCell.self)
                    .then {
                        $0.bindModel(CastCrewModel(castCrew: castCrew))
                    }
                return cell
            })
        
        output.castCrewList
            .drive(movieCastCrewCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        output.isEmptyCastCrewList
            .drive(movieCastCrewCollectionView.rx.isEmptyData)
            .disposed(by: rx.disposeBag)
    }
}

// MARK: - Binding Model
extension MovieDetailViewController {
    var model: Binder<MovieDetailModel> {
        return Binder(self) { viewController, movieDetailModel in
            viewController.do {
                $0.movieBackdropImageView.sd_setImage(with: movieDetailModel.backdropURL, completed: nil)
                $0.moviePosterImageView.sd_setImage(with: movieDetailModel.posterURL, completed: nil)
                $0.movieTitleLabel.text = movieDetailModel.title
                $0.movieRatingView.rating = movieDetailModel.voteAverage
                $0.movieRatingView.text = movieDetailModel.voteAverageString
                $0.movieLanguageLabel.text = movieDetailModel.language
                $0.movieDurationLabel.text = movieDetailModel.duration
                $0.movieOverviewLabel.text = movieDetailModel.overview
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
    struct LayoutOption {
        var topInset: CGFloat = 0
        var bottomInset: CGFloat = 0
        var leftInset: CGFloat = 10
        var rightInset: CGFloat = 10
        var sectionInsets: UIEdgeInsets {
            return UIEdgeInsets(top: topInset,
                                left: leftInset,
                                bottom: bottomInset,
                                right: rightInset)
        }
        var itemSpacing: CGFloat = 10
        var lineSpacing: CGFloat = 10
        var itemWidth = 96
        var itemHeight = 128
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return layoutOption.sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return layoutOption.itemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return layoutOption.lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: layoutOption.itemWidth,
                      height: layoutOption.itemHeight)
    }
}

// MARK: - StotyboardSceneBased
extension MovieDetailViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.movieDetail
}
