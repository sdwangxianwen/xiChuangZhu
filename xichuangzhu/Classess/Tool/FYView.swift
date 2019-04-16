//
//  FYView.swift
//  qhm
//
//  Created by wang on 2019/4/12.
//  Copyright © 2019 wang. All rights reserved.
//uiview属性扩展

import UIKit
//渐变色的方向
public enum UIViewGradientDirection {
    case horizontally
    case vertically
}

public extension UIView {
    /// x
    var fy_x: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    ///y
    var fy_y : CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
            
        }
    }
    
    ///height
    var fy_height : CGFloat {
        get {
            return frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame = tempFrame
        }
    }
    
    ///width
    var fy_width : CGFloat {
        get {
            return frame.size.width
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    //size
    var fy_size : CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    //centerx
    var fy_centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    ///centery
    var fy_centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter
        }
    }
    
    ///origin
    var fy_origin : CGPoint {
        get {
            return frame.origin
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin = newValue
            frame = tempFrame
        }
    }
    
    ///maxX
    var fy_maxX : CGFloat {
        get {
            return frame.origin.x + frame.size.width;
        }
    }
    
    ///maxY
    var fy_maxY : CGFloat {
        get {
            return frame.origin.y + frame.size.height
        }
    }
    
    ///minX
    var fy_minX : CGFloat {
        get{
            return frame.minX
        }
    }
    
    ///minY
    var fy_minY : CGFloat {
        get{
            return frame.minY
        }
    }
    
    /// e设置指定位置的圆角
    ///
    /// - Parameters:
    ///   - corners: 位置,上下左右
    ///   - radius: 角度
    func customRectCorner(corners: UIRectCorner,radius:CGFloat) {
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    
    /// 设置指定部位的圆角
    @discardableResult
    func fy_borderSpecified(_ specified: UIRectCorner,cornerRadius:CGFloat) -> UIView {
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: specified, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        return self
    }
    //view的渐变色
    func fy_addGradientLayer(gradientColors: [UIColor],gradientDirection direction: UIViewGradientDirection, gradientFrame: CGRect? = nil) {
        
        //创建并实例化CAGradientLayer
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        //设置frame和插入view的layer
        if let gradientFrame = gradientFrame {
            gradientLayer.frame = gradientFrame
        }else {
            gradientLayer.frame = CGRect(x: 0, y: 0, width: fy_width, height: fy_height)
        }
        
        gradientLayer.colors = gradientColors.map({ (color) -> CGColor in
            return color.cgColor
        })
        //(这里的起始和终止位置就是按照坐标系,四个角分别是左上(0,0),左下(0,1),右上(1,0),右下(1,1))
        if direction == .horizontally {
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint.init(x: 1, y: 0.5)
        }else {
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint.init(x: 0, y: 1)
        }
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension UIImage {
    //根据颜色创建一个纯Image
    func imageUseColor(color : String) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context : CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(UIColor.init(hexString:color).cgColor)
        context.fill(rect)
        let image : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

class FYView: NSObject {

}
