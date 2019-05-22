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
        configSubviews()
    }
    
    private func configSubviews() {
        reviewImageView.makeRounded(radius: reviewImageView.frame.height / 2)
    }
    
    func bindModel(_ model: ReviewModel?) {
        if let model = model {
            model.do {
                reviewNameLabel.text = $0.author
                reviewContentLabel.text = $0.content
                reviewImageView.sd_setImage(with: $0.avatarURL, completed: nil)
            }
        } else {
            reviewNameLabel.text = ""
            reviewContentLabel.text = ""
            reviewImageView.image = nil
        }
    }
}
