//
//  UIColor+.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: Int = 1) {
        self.init(red: CGFloat(red) / 255,
                  green: CGFloat(green) / 255,
                  blue: CGFloat(blue) / 255,
                  alpha: CGFloat(alpha))
    }
    
    convenience init(hex: Int) {
        self.init(red: (hex >> 16) & 0xFF,
                  green: (hex >> 8) & 0xFF,
                  blue: hex & 0xFF)
    }
    
    @nonobjc class var ghostWhite: UIColor {
        return UIColor(hex: 0xF8F8F8)
    }
    
    @nonobjc class var pearlAqua: UIColor {
        return UIColor(hex: 0x84DCC6)
    }
    
    @nonobjc class var magicMint: UIColor {
        return UIColor(hex: 0xA5FFD6)
    }
    
    @nonobjc class var lightSalmonPink: UIColor {
        return UIColor(hex: 0xFFA69E)
    }
    
    @nonobjc class var pastelRed: UIColor {
        return UIColor(hex: 0xFF686B)
    }
    
    @nonobjc class var burlywood: UIColor {
        return UIColor(hex: 0xDCCB84)
    }
}
