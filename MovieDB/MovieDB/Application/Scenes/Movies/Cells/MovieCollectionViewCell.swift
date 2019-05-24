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
    
    func bindModel(_ model: MovieModel?) {
        if let model = model {
            model.do {
                moviePosterImageView.sd_setImage(with: $0.posterURL, completed: nil)
                movieTitleLabel.text = $0.title
                movieOverviewLabel.text = $0.overview
                movieVoteLabel.text = $0.vote
                movieVoteLabel.textColor = $0.voteTextColor
                movieVoteLabel.isHidden = $0.isVoteHidden
                movieVoteView.isHidden = $0.isVoteHidden
            }
        } else {
            moviePosterImageView.image = nil
            movieTitleLabel.text = ""
            movieOverviewLabel.text = ""
            movieVoteLabel.isHidden = true
            movieVoteView.isHidden = true
        }
    }
}
