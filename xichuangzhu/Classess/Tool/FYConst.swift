//
//  FYConst.swift
//  qhm
//
//  Created by wang on 2019/4/12.
//  Copyright © 2019 wang. All rights reserved.
//参数设置

import UIKit

/// 判断是否为iphonex 系列
///
/// - Returns: Bool
func isPhoneX() ->Bool {
    if #available(iOS 11.0, *) {
        if (UIApplication.shared.delegate as? AppDelegate )?.window?.safeAreaInsets.bottom != 0 {
            return true
        }
    }
    return false
}
//屏幕宽度
let kScreenWidth = UIScreen.main.bounds.size.width
/// 屏幕高度
let kScreenHeigth = UIScreen.main.bounds.size.height
/// tabBar高度
let TabBarHeight:CGFloat = isPhoneX() ? 83 : 49
/// nav高度
let NavBarHeight:CGFloat = isPhoneX() ? 88 : 64
/// 底部手势框的高度
let BottomLineHeight : CGFloat = isPhoneX() ? 34 : 0

/// 设置随机颜色
func UIColorRandom() -> UIColor {
    let color: UIColor = UIColor.init(red: (((CGFloat)((arc4random() % 256)) / 255.0)), green: (((CGFloat)((arc4random() % 256)) / 255.0)), blue: (((CGFloat)((arc4random() % 256)) / 255.0)), alpha: 1.0);
    return color;
}

// MARK: - 颜色的设置
extension UIColor {
    
    /*
     convenience:便利，使用convenience修饰的构造函数叫做便利构造函数
     便利构造函数通常用在对系统的类进行构造函数的扩充时使用。
     便利构造函数的特点：
     1、便利构造函数通常都是写在extension里面
     2、便利函数init前面需要加载convenience
     3、在便利构造函数中需要明确的调用self.init()
     */
    convenience init(hexString: String) {
        self.init(hexString: hexString,alpha: 1)
    }
    
    convenience init(hexString: String, alpha: CGFloat) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (r, g, b) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: alpha)
    }
    
    
    /// 使用Int值快速创建颜色
    convenience init(redValue: Int, green: Int, blue: Int, alpha: CGFloat) {
        self.init(red: CGFloat(redValue) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    //let color = UIColor(hex: "ff0000")
    
}

class FYConst: NSObject {

}
