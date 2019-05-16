//
//  CategoriesMovieCollectionViewCell.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/15/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit
import SDWebImage

final class CategoriesMovieCollectionViewCell: UICollectionViewCell, NibReusable {
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieVoteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configSubviews()
    }
    
    private func configSubviews() {
        shadowView.makeRoundedAndShadowed()
        containerView.makeRounded()
    }
    
    func bindModel(_ model: CategoriesMovieModel?) {
        if let model = model {
            movieImageView.sd_setImage(with: model.posterURL, completed: nil)
            movieNameLabel.text = model.title
            movieYearLabel.text = model.year
            movieVoteLabel.text = model.vote
            movieVoteLabel.textColor = model.voteTextColor
        } else {
            movieImageView.image = nil
            movieNameLabel.text = ""
            movieYearLabel.text = ""
            movieVoteLabel.text = ""
        }
    }
}
