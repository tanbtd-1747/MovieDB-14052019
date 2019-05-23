//
//  CastCrewViewController.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/21/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

final class CastCrewViewController: UIViewController, BindableType {
    @IBOutlet weak var castCrewImageView: UIImageView!
    @IBOutlet weak var castCrewNameLabel: UILabel!
    @IBOutlet weak var castCrewSegmentedControl: TTSegmentedControl!
    @IBOutlet weak var castCrewCreditsCollectionView: UICollectionView!
    @IBOutlet weak var backButton: UIButton!
    
    var viewModel: CastCrewViewModel!
    
    private let layoutOption = LayoutOption()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configCredits()
    }
    
    private func configSubviews() {
        backButton.makeRounded()
        castCrewImageView.makeRounded(radius: castCrewImageView.frame.height / 2)
        
        castCrewSegmentedControl.do {
            $0.defaultTextFont = UIFont.avenirBook(size: .smallFontSize)
            $0.selectedTextFont = UIFont.avenirBook(size: .mediumFontSize)
            $0.allowChangeThumbWidth = false
            $0.itemTitles = [String](repeating: "", count: Constant.creditTitles.count)
        }
        
        castCrewCreditsCollectionView.do {
            $0.delegate = self
            $0.register(cellType: CreditCollectionViewCell.self)
        }
    }
    
    private func configCredits() {
        Constant.creditTitles
            .enumerated()
            .forEach { (index, title) in
                castCrewSegmentedControl.changeTitle(title, atIndex: index)
            }
    }
    
    func bindViewModel() {
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CastCrewViewController: UICollectionViewDelegateFlowLayout {
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
        var lineSpacing: CGFloat = 10
        var itemSpacing: CGFloat = 10
        var numColumns = 4
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
extension CastCrewViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.castCrew
}
