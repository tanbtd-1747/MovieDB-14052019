//
//  AlternateMovieCollectionViewCell.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/24/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

final class AlternateMovieCollectionViewCell: UICollectionViewCell, NibReusable {
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieVoteProgressView: UIProgressView!
    @IBOutlet weak var movieBackdropImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configSubviews()
    }
    
    private func configSubviews() {
        shadowView.makeRoundedAndShadowed()
        containerView.makeRounded()
    }
    
    func bindViewModel(_ model: MovieViewModel?) {
        movieBackdropImageView.sd_setImage(with: model?.backdropURL, completed: nil)
        movieTitleLabel.text = model?.title ?? ""
        movieDateLabel.text = model?.releaseDate ?? ""
        movieVoteProgressView.setProgress(model?.voteProgress ?? 0.0, animated: true)
    }
}
