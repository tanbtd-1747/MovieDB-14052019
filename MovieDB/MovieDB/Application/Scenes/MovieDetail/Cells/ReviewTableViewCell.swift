//
//  ReviewTableViewCell.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/20/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

final class ReviewTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet weak var reviewImageView: UIImageView!
    @IBOutlet weak var reviewNameLabel: UILabel!
    @IBOutlet weak var reviewContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
