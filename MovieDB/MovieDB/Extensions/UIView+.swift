//
//  UIView+.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/15/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

extension UIView {
    func makeRounded(radius: CGFloat = 6) {
        layer.cornerRadius = radius
    }
    
    func makeShadowed(color: UIColor,
                      radius: CGFloat,
                      offset: CGSize,
                      opacity: Float) {
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
    }
    
    func makeRoundedAndShadowed(cornerRadius: CGFloat = 6,
                                shadowColor: UIColor = .black,
                                shadowRadius: CGFloat = 3,
                                shadowOffset: CGSize = CGSize(width: 0, height: 1),
                                shadowOpacity: Float = 0.4) {
        makeRounded(radius: cornerRadius)
        makeShadowed(color: shadowColor,
                     radius: shadowRadius,
                     offset: shadowOffset,
                     opacity: shadowOpacity)
    }
}
