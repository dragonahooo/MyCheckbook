//
//  ColorUtils.swift
//  MyCheckbook
//
//  Created by ho on 2017/10/1.
//  Copyright © 2017年 ho. All rights reserved.
//

import Foundation
import UIKit

public class ColorUtils{
    
    static public var APP_BG_COLOR:UIColor = UIRGB(rgbValue: 0xff6c2f);
    
    static func UIRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
