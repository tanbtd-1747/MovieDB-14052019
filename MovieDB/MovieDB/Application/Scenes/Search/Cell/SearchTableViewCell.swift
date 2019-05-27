//
//  SearchTableViewCell.swift
//  MovieDB
//
//  Created by Duc Pham on 5/20/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

final class SearchTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func prepareForReuse() {
        titleLable.text = ""
        posterImageView.image = nil
        super.prepareForReuse()
    }
    
    func bindViewModel(_ viewModel: MovieViewModel?) {
        if let viewModel = viewModel {
            titleLable.text = viewModel.title
            posterImageView?.sd_setImage(with: viewModel.backdropURL,
                                         completed: nil)
        } else {
            titleLable.text = ""
            posterImageView.image = nil
        }
    }
}
