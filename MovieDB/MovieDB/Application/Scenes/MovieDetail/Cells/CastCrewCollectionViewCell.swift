//
//  CastCrewCollectionViewCell.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/20/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

final class CastCrewCollectionViewCell: UICollectionViewCell, NibReusable {
    @IBOutlet weak var crewImageView: UIImageView!
    @IBOutlet weak var crewName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configSubviews()
    }
    
    private func configSubviews() {
        crewImageView.makeRoundedAndShadowed()
    }
}
