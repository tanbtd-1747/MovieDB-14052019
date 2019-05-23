//
//  CreditCollectionViewCell.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/23/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

final class CreditCollectionViewCell: UICollectionViewCell, NibReusable {
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var creditImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configSubviews()
    }
    
    private func configSubviews() {
        shadowView.makeRoundedAndShadowed()
        creditImageView.makeRounded()
    }
}
