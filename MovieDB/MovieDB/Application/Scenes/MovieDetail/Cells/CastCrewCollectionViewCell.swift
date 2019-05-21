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
    @IBOutlet weak var crewNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configSubviews()
    }
    
    private func configSubviews() {
        crewImageView.makeRounded()
    }
    
    func bindModel(_ model: CastCrewModel?) {
        if let model = model {
            model.do {
                crewNameLabel.text = $0.name
                crewImageView.sd_setImage(with: $0.profileURL, completed: nil)
            }
        } else {
            crewImageView.image = nil
            crewNameLabel.text = ""
        }
    }
}
