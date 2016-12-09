//
//  UIBalloonLabelArrowView.swift
//  Sandbox
//
//  Created by Gene M. Angelo  Jr. on 12/8/16.
//  Copyright © 2016 Mohojo Werks LLC. All rights reserved.
//

import UIKit
import Foundation

class UIBalloonLabelArrowView: UIView,  BalloonLabelProtocol {
   fileprivate var _lineWidth:CGFloat?
   fileprivate var _borderColor:UIColor?
   
   fileprivate var _arrowWidth:CGFloat?
   fileprivate var _arrowHeight:CGFloat?
   
   override public init(frame: CGRect) {
      super.init(frame: frame)
      
      setUp()
   }
   
   required public init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      
      setUp()
   }
   
   fileprivate func setUp() {
   }
   
   var borderColor:UIColor {
      get {
         if let borderColor = self._borderColor {
            return borderColor
         } else {
            return UIBalloonLabel.getDefaultBorderColor()
         }
      }
      
      set {
         self._borderColor = newValue
      }
   }
   
   var lineWidth:CGFloat {
      get {
         if let lineWidth = self._lineWidth {
            return lineWidth
         } else{
            return UIBalloonLabel.getDefaultLineWidth()
         }
      }
      
      set {
         self._lineWidth = newValue
      }
   }
   
   var arrowWidth:CGFloat {
      get {
         if let arrowWidth = self._arrowWidth {
            return arrowWidth
         } else{
            return UIBalloonLabel.getDefaultArrowWidth()
         }
      }
      
      set {
         self._arrowWidth = newValue
      }
   }
   
   var arrowHeight:CGFloat {
      get {
         if let arrowHeight = self._arrowHeight {
            return arrowHeight
         } else{
            return UIBalloonLabel.getDefaultArrowHeight()
         }
      }
      
      set {
         self._arrowHeight = newValue
      }
   }
   
   @IBInspectable var cornerRadius: CGFloat = 0 {
      didSet {
         layer.cornerRadius = cornerRadius
         layer.masksToBounds = cornerRadius > 0
      }
   }
   
   @IBInspectable var borderWidth: CGFloat = 0 {
      didSet {
         layer.borderWidth = borderWidth
      }
   }
   
   override open func draw(_ rect: CGRect) {
      super.draw(rect)
      drawBorder(rect)
   }
   
   func drawBorder(_ rect: CGRect) {
      let minX: CGFloat = rect.minX
      let maxX: CGFloat = rect.maxX
      
      let minY: CGFloat = rect.minY + (arrowHeight + 2)
      let maxY: CGFloat = rect.maxY
      
      // Top left
      let startingPointTopLeft = CGPoint(x: minX, y: minY)
      let endingPointTopLeft = CGPoint(x: (maxX / 2) - (arrowWidth / 2), y: minY)
      
      // Top right
      let startingPointTopRight = CGPoint(x: (maxX / 2) + (arrowWidth / 2), y: minY)
      let endingPointTopRight = CGPoint(x: maxX, y: minY)
      
      // Left side
      let startingPointLeftSide = CGPoint(x: minX, y: minY)
      let endingPointLeftSide = CGPoint(x: minX, y: maxY)

      // Right side
      let startingPointRightSide = CGPoint(x: maxX, y: minY)
      let endingPointRightSide = CGPoint(x: maxX, y: maxY)
      
      // Arrow left side
      let startingPointArrowLeft = CGPoint(x: (maxX / 2) - (arrowWidth / 2), y: minY)
      let endingPointArrowLeft = CGPoint(x: (maxX / 2), y: minY - arrowHeight)
      
      // Arror right side
      let startingPointArrowRight = CGPoint(x: (maxX / 2) + (arrowWidth / 2), y: minY)
      let endingPointArrowRight = CGPoint(x: (maxX / 2), y: minY - arrowHeight)
      
      // Bottom
      let startingPointBottom = CGPoint(x: minX, y: maxY)
      let endingPointBottom = CGPoint(x: maxX, y: maxY)
      
      let path = UIBezierPath()
      
      // Top left
      path.move(to: startingPointTopLeft)
      path.addLine(to: endingPointTopLeft)
      
      // Top right
      path.move(to: startingPointTopRight)
      path.addLine(to: endingPointTopRight)
      
      // Left side
      path.move(to: startingPointLeftSide)
      path.addLine(to: endingPointLeftSide)

      // Right side
      path.move(to: startingPointRightSide)
      path.addLine(to: endingPointRightSide)
      
      // Arrow left side
      path.move(to: startingPointArrowLeft)
      path.addLine(to: endingPointArrowLeft)
      
      // Arrow right side
      path.move(to: startingPointArrowRight)
      path.addLine(to: endingPointArrowRight)
      
      // Bottom
      path.move(to: startingPointBottom)
      path.addLine(to: endingPointBottom)
      
      path.lineWidth = self.lineWidth
      
      let color:UIColor = self.borderColor
      color.setStroke()
      
      path.stroke()
   }
}
