//
//  XJShapedButton.swift
//  XJShapedButton
//
//  Created by 万旭杰 on 16/6/21.
//  Copyright © 2016年 万旭杰. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

class XJShapedButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var previousTouchPoint: CGPoint = CGPoint.zero
    var previousTouchHitFlag: Bool = false
    var buttonImage: UIImage = UIImage()
    var buttonBackground: UIImage = UIImage()
    
    func setup() {
        self.updateImageForCurrentState()
    }
    
    func isAlphaVisible(point: CGPoint, image: UIImage) -> Bool {
        let iSize = image.size
        let bSize = self.bounds.size
        let imageX = point.x * ((bSize.width != 0) ? (iSize.width / bSize.width) : 1)
        let imageY = point.y * ((bSize.width != 0) ? (iSize.height / bSize.height) : 1)
        return image.hasAlpha(CGPoint(x: imageX, y: imageY))
    }
    
    //MARK: Override
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        let superResult = super.pointInside(point, withEvent: event)
        if !superResult {
            return superResult
        }
        
        // don't check the same point 
        if CGPointEqualToPoint(point, self.previousTouchPoint) {
            return self.previousTouchHitFlag
        } else {
            self.previousTouchPoint = point
        }
        
        var response = false
        
        if  buttonImage.isNil() && buttonBackground.isNil() {
            response = true
        } else if !buttonImage.isNil() && buttonBackground.isNil() {
            response = self.isAlphaVisible(point, image: buttonImage)
        } else if buttonImage.isNil() && !buttonBackground.isNil() {
            response = self.isAlphaVisible(point, image: buttonBackground)
        } else {
            if self.isAlphaVisible(point, image: buttonImage) {
                response = true
            } else {
                response = self.isAlphaVisible(point, image: buttonBackground)
            }
        }
        self.previousTouchHitFlag = response
        return response
    }
    
    override func setImage(image: UIImage?, forState state: UIControlState) {
        super.setImage(image, forState: state)
        self.updateImageForCurrentState()
        if let size = image?.size {
            self.frame.size = size
        }
        self.resetHitCache()
    }
    
    override func setBackgroundImage(image: UIImage?, forState state: UIControlState) {
        super.setBackgroundImage(image, forState: state)
        self.updateImageForCurrentState()
        self.resetHitCache()
    }
    
    override var enabled: Bool {
        didSet {
            self.updateImageForCurrentState()
        }
    }
    
    override var highlighted: Bool {
        didSet {
            self.updateImageForCurrentState()
        }
    }
    
    override var selected: Bool {
        didSet {
            self.updateImageForCurrentState()
        }
    }
    
    //MARK: SetImage Or Cache
    func updateImageForCurrentState() {
        if let image = self.currentImage {
            buttonImage = image
        }
        if let image = self.currentBackgroundImage {
            buttonBackground = image
        }
    }
    
    func resetHitCache() {
        previousTouchPoint = CGPoint.zero
        previousTouchHitFlag = false
    }
}