//
//  MoviesCollectionViewCell.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/15/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit
import SDWebImage

final class MovieCollectionViewCell: UICollectionViewCell, NibReusable {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var contentViewBig: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.do {
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOffset = CGSize(width: -1.0, height: 1.0)
            $0.layer.shadowOpacity = 5
            $0.layer.shadowRadius = 4.0
            $0.layer.cornerRadius = 4.0
        }
        
        contentViewBig.layer.cornerRadius = 5.0
    }
    
    func bindModel(_ model: MovieModel?) {
        if let model = model {
            model.do {
                textLabel.text = $0.title
                posterImageView?.sd_setImage(with: URL(string: API.Urls.mediaBackdropPath + viewModel.backdropPath),
                                             completed: nil)
                backdropImageView?.sd_setImage(with: URL(string: API.Urls.mediaBackdropPath + viewModel.posterPath),
                                               completed: nil)
            }
        } else {
            textLabel.text = ""
            posterImageView.image = nil
            backdropImageView.image = nil
        }
    }
}
