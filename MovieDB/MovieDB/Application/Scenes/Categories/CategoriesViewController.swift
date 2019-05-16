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
        Constant.categories
            .enumerated()
            .forEach { (index, title) in
                categoriesSegmentedControl.changeTitle(title, atIndex: index)
            }
    }
    
    func bindViewModel() {
        
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
