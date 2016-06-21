//
//  UIImageExt.swift
//  XJShapedButton
//
//  Created by 万旭杰 on 16/6/21.
//  Copyright © 2016年 万旭杰. All rights reserved.
//

import UIKit
import Foundation
import CoreGraphics

extension UIImage {
    func colorAtPoint(pos: CGPoint) -> UIColor? {
        if !CGRectContainsPoint(CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height), pos) {
            return nil
        }
        
        // Retrieving a pixel alpha value for a UIImage :
        // http://stackoverflow.com/questions/25146557/how-do-i-get-the-color-of-a-pixel-in-a-uiimage-with-swift
        
        let pixelData = CGDataProviderCopyData(CGImageGetDataProvider(self.CGImage))
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    func hasAlpha(pos: CGPoint) -> Bool {
        let pixelData = CGDataProviderCopyData(CGImageGetDataProvider(self.CGImage))
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4 // The image is png
        
        let alpha = data[pixelInfo + 3]     // I need only this info
        
        if alpha > 0 {
            return true
        }
        else {
            return false
        }
    }
    
    func isNil() -> Bool {
        if CGSizeEqualToSize(CGSize.zero, self.size) {
            return true
        }
        return false
    }
}
