//
//  FavoritesCell.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/22/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

final class FavoritesCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var posterPath: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    func bindViewModel(_ viewModel: FavoriteViewModel?) {
        if let viewModel = viewModel {
            title.text = viewModel.title
            posterPath.sd_setImage(with: URL(string: API.Urls.backdropUrl + viewModel.posterPath), completed: nil)
        } else {
            title.text = ""
            posterPath.image = nil
        }
    }
}
