//
//  CategoriesViewController.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

final class CategoriesViewController: UIViewController, BindableType {
    @IBOutlet weak var categoriesSegmentedControl: TTSegmentedControl!
    @IBOutlet weak var categoriesMoviesCollectionView: LoadMoreCollectionView!
    
    private let layoutOption = LayoutOption()
    
    var viewModel: CategoriesViewModel!
    
    deinit {
        logDeinit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hideNavigationBar()
        configCategories()
    }
    
    private func configSubviews() {
        categoriesSegmentedControl.do {
            $0.defaultTextFont = UIFont.avenirBook(size: .smallFontSize)
            $0.selectedTextFont = UIFont.avenirBook(size: .mediumFontSize)
            $0.allowChangeThumbWidth = false
        }
        
        categoriesMoviesCollectionView.do {
            $0.delegate = self
            $0.register(cellType: CategoriesMovieCollectionViewCell.self)
        }
    }
    
    private func configCategories() {
        Constant.categoryTitles
            .enumerated()
            .forEach { (index, title) in
                categoriesSegmentedControl.changeTitle(title, atIndex: index)
            }
    }
    
    func bindViewModel() {
        let loadTrigger = categoriesSegmentedControl.rx.selectedSegmentIndex
            .map {
                Constant.categories[$0]
            }
            .asDriverOnErrorJustComplete()
        let reloadTrigger = categoriesMoviesCollectionView.refreshTrigger
            .withLatestFrom(loadTrigger)
        let loadMoreTrigger = categoriesMoviesCollectionView.loadMoreTrigger
            .withLatestFrom(loadTrigger)
        
        let input = CategoriesViewModel.Input(
            loadTrigger: loadTrigger,
            reloadTrigger: reloadTrigger,
            loadMoreTrigger: loadMoreTrigger,
            selectMovieTrigger: categoriesMoviesCollectionView.rx.itemSelected.asDriver()
        )
        
        let output = viewModel.transform(input)
        
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        output.loading
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
        output.refreshing
            .drive(categoriesMoviesCollectionView.refreshing)
            .disposed(by: rx.disposeBag)
        output.loadingMore
            .drive(categoriesMoviesCollectionView.loadingMore)
            .disposed(by: rx.disposeBag)
        output.fetchItems
            .drive()
            .disposed(by: rx.disposeBag)
        output.selectedMovie
            .drive()
            .disposed(by: rx.disposeBag)
        output.scrollToTop
            .drive(onNext: { [unowned self] in
                self.categoriesMoviesCollectionView.setContentOffset(.zero, animated: true)
            })
            .disposed(by: rx.disposeBag)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<Section<Movie>>(
            configureCell: { _, collectionView, indexPath, movie in
                let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                              cellType: CategoriesMovieCollectionViewCell.self)
                    .then {
                        $0.bindModel(CategoriesMovieModel(movie: movie))
                    }
                return cell
            })
        
        output.moviesList
            .map { movies in
                return [Section<Movie>(items: movies)]
            }
            .drive(categoriesMoviesCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
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
        var itemSpacing: CGFloat = 20
        var numColumns = 2
        var ratio: CGFloat = 1.5
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
extension CategoriesViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
