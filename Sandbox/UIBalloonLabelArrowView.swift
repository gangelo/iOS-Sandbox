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
   
   override public func draw(_ rect: CGRect) {
      super.draw(rect)
      drawBorder(rect: rect)
   }
   
   func drawBorder(rect: CGRect) {
      // Top left
      let startingPointLeft = CGPoint(x: rect.minX, y: rect.minY)
      let endingPointLeft = CGPoint(x: (rect.maxX / 2) - (arrowWidth / 2), y: rect.minY)
      
      // Top right
      let startingPointRight = CGPoint(x: (rect.maxX / 2) + (arrowWidth / 2), y: rect.minY)
      let endingPointRight = CGPoint(x: rect.maxX, y: rect.minY)
      
      // Left side
      let startingPointLeftSide = CGPoint(x: rect.minX, y: rect.minY)
      let endingPointLeftSide = CGPoint(x: rect.minX, y: rect.maxY)

      // Right side
      let startingPointRightSide = CGPoint(x: rect.maxX, y: rect.minY)
      let endingPointRightSide = CGPoint(x: rect.maxX, y: rect.maxY)

      
      let path = UIBezierPath()
      
      // Top left
      path.move(to: startingPointLeft)
      path.addLine(to: endingPointLeft)
      
      // Top right
      path.move(to: startingPointRight)
      path.addLine(to: endingPointRight)
      
      // Left side
      path.move(to: startingPointLeftSide)
      path.addLine(to: endingPointLeftSide)

      // Right side
      path.move(to: startingPointRightSide)
      path.addLine(to: endingPointRightSide)

      
      /*
       let arrowSize = CGFloat(8.0);
       
       let startingPoint = CGPoint(x: rect.minX, y: rect.maxY)
       let endingPoint = CGPoint(x: rect.maxX, y: rect.maxY)
       
       let topLeft = CGPoint(x: rect.minX, y: rect.minY)
       
       let topMiddleLeft = CGPoint(x: (rect.maxX / 2) - arrowSize, y: rect.minY)
       let topMiddleRight = CGPoint(x: (rect.maxX / 2) + arrowSize, y: rect.minY)
       
       
       let topRight = CGPoint(x: rect.maxX, y: rect.minY)
       
       
       let path = UIBezierPath()
       
       // Top left
       path.move(to: topLeft)
       path.addLine(to: topMiddleLeft)
       
       // Arrow here / and \
       path.move(to: topMiddleLeft)
       path.addLine(to: CGPoint(x: (rect.maxX / 2) , y: rect.minY))
       
       // Top right
       path.move(to: topMiddleRight)
       path.addLine(to: topRight)
       
       
       // Bottom
       path.move(to: startingPoint)
       path.addLine(to: endingPoint)
       */
      
      path.lineWidth = self.lineWidth
      
      let color:UIColor = self.borderColor
      color.setStroke()
      
      path.stroke()
   }
}
