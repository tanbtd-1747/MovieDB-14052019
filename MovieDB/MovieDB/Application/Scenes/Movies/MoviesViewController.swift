//
//  MoviesViewController.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit
import Foundation

final class MoviesViewController: UIViewController, BindableType {
    @IBOutlet weak var collectionView: LoadMoreCollectionView!
    @IBOutlet weak var searchButton: UIButton!
    
    private var layoutOption = LayoutOption()

    var viewModel: MoviesViewModel!
    
    deinit {
        logDeinit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideTabBar(false)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationController?.isNavigationBarHidden = true
    }
    
    private func configSubviews() {
        collectionView.do {
            $0.register(cellType: MovieCollectionViewCell.self)
            $0.register(cellType: AlternateMovieCollectionViewCell.self)
            $0.delegate = self
        }
    }
    
    func bindViewModel() {
        let loadTrigger = Driver<CategoryType>.just(.upcoming)
        let reloadTrigger = collectionView.refreshTrigger
            .withLatestFrom(loadTrigger)
        let loadMoreTrigger = collectionView.loadMoreTrigger
            .withLatestFrom(loadTrigger)
        
        let input = MoviesViewModel.Input(
            loadTrigger: loadTrigger,
            reloadTrigger: reloadTrigger,
            loadMoreTrigger: loadMoreTrigger,
            selectMovieTrigger: collectionView.rx.itemSelected.asDriver(),
            toSearchTrigger: searchButton.rx.tap.asDriver()
        )
        
        let output = viewModel.transform(input)
        
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        output.loading
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
        output.refreshing
            .drive(collectionView.refreshing)
            .disposed(by: rx.disposeBag)
        output.loadingMore
            .drive(collectionView.loadingMore)
            .disposed(by: rx.disposeBag)
        output.fetchItems
            .drive()
            .disposed(by: rx.disposeBag)
        output.selectedMovie
            .drive()
            .disposed(by: rx.disposeBag)
        output.isEmptyData
            .drive()
            .disposed(by: rx.disposeBag)
        output.toSearch
            .drive()
            .disposed(by: rx.disposeBag)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<Section<MoviesViewModel.CellType>>(
            configureCell: { _, collectionView, indexPath, cellType in
                switch cellType {
                case .main(let movie):
                    return collectionView.dequeueReusableCell(for: indexPath,
                                                              cellType: MovieCollectionViewCell.self)
                        .then {
                            $0.bindModel(MovieModel(movie: movie))
                        }
                case .alternate(let movie):
                    return collectionView.dequeueReusableCell(for: indexPath,
                                                              cellType: AlternateMovieCollectionViewCell.self)
                        .then {
                            $0.bindModel(MovieModel(movie: movie))
                        }
                }
            })
        
        output.movieList
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    struct LayoutOption {
        var topInset: CGFloat = 10
        var bottomInset: CGFloat = 10
        var leftInset: CGFloat = 10
        var rightInset: CGFloat = 10
        var sectionInsets: UIEdgeInsets {
            return UIEdgeInsets(top: topInset,
                                left: leftInset,
                                bottom: bottomInset,
                                right: rightInset)
        }
        var lineSpacing: CGFloat = 20
        var itemSpacing: CGFloat = 10
        var numColumns = 1
        var ratio: CGFloat = 0.6
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
        var width = collectionView.bounds.width
        width -= CGFloat(layoutOption.numColumns - 1) * layoutOption.itemSpacing
        width -= layoutOption.leftInset + layoutOption.rightInset
        width /= CGFloat(layoutOption.numColumns)
        let height = layoutOption.ratio * width
        
        return CGSize(width: width, height: height)
    }
}

// MARK: - StotyboardSceneBased
extension MoviesViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
