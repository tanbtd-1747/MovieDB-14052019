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
    @IBOutlet weak var categoriesMoviesCollectionView: UICollectionView!
    
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
        configCategories()
    }
    
    private func configSubviews() {
        categoriesSegmentedControl.do {
            if let font = UIFont(name: Constant.appFontName, size: Constant.appSmallFontSize) {
                $0.defaultTextFont = font
            }
            if let font = UIFont(name: Constant.appFontName, size: Constant.appMediumFontSize) {
                $0.selectedTextFont = font
            }
            $0.allowChangeThumbWidth = false
        }
        
        categoriesMoviesCollectionView.do {
            $0.delegate = self
            $0.register(cellType: CategoriesMovieCollectionViewCell.self)
        }
    }
    
    private func configCategories() {
        Constant.categories
            .enumerated()
            .forEach { (index, title) in
                categoriesSegmentedControl.changeTitle(title, atIndex: index)
            }
    }
    
    func bindViewModel() {
        
    }
}

extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constant.categoriesMoviesCollectionViewVerticalInset,
                            left: Constant.categoriesMoviesCollectionViewHorizontalInset,
                            bottom: Constant.categoriesMoviesCollectionViewVerticalInset,
                            right: Constant.categoriesMoviesCollectionViewHorizontalInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constant.categoriesMovieCollectionViewHorizontalSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constant.categoriesMoviesCollectionViewVerticalSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numColumns = 2
        
        let width = (collectionView.bounds.width
            - Constant.categoriesMovieCollectionViewHorizontalSpacing
            - 2 * Constant.categoriesMoviesCollectionViewHorizontalInset) / CGFloat(numColumns)
        let height = 1.5 * width
        
        return CGSize(width: width, height: height)
    }
}

// MARK: - StotyboardSceneBased
extension CategoriesViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
