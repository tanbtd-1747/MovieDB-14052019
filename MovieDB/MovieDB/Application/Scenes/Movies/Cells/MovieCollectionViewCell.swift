//
//  MovieCollectionViewCell.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/15/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit
import SDWebImage

final class MovieCollectionViewCell: UICollectionViewCell, NibReusable {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieVoteView: UIView!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieVoteLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configSubviews()
    }
    
    private func configSubviews() {
        moviePosterImageView.makeRoundedAndShadowed()
        movieVoteView.makeRounded(radius: movieVoteView.frame.height / 2)
        containerView.makeRounded()
    }
    
    func bindViewModel(_ model: MovieViewModel?) {
        moviePosterImageView.sd_setImage(with: model?.posterURL, completed: nil)
        movieTitleLabel.text = model?.title ?? ""
        movieOverviewLabel.text = model?.overview ?? ""
        movieVoteLabel.text = model?.vote ?? ""
        movieVoteLabel.textColor = model?.voteTextColor ?? .white
        movieVoteLabel.isHidden = model?.isVoteHidden ?? true
        movieVoteView.isHidden = model?.isVoteHidden ?? true
    }
}
