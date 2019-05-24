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
    
    func bindModel(_ model: MovieModel?) {
        if let model = model {
            model.do {
                movieBackdropImageView.sd_setImage(with: $0.backdropURL, completed: nil)
                movieTitleLabel.text = $0.title
                movieDateLabel.text = $0.releaseDate
                movieVoteProgressView.setProgress($0.voteProgress, animated: true)
            }
        } else {
            movieBackdropImageView.image = nil
            movieTitleLabel.text = ""
            movieDateLabel.text = ""
            movieVoteProgressView.setProgress(0, animated: true)
        }
    }
}
