//
//  UIBalloonLabelLabel.swift
//  Sandbox
//
//  Created by Gene M. Angelo  Jr. on 12/7/16.
//  Copyright © 2016 Mohojo Werks LLC. All rights reserved.
//

import UIKit

class UIBalloonLabelLabel: UILabel,  BalloonLabelProtocol {
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
      //if let margins = superview?.layoutMarginsGuide {
      //   self.topAnchor.constraint(equalTo: margins.topAnchor, constant: arrowHeight * 2)
      //   //self.leadingAnchor.constraintEqualToAnchor(margins.topAnchor).active = true
      //}
      
      //NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .leadingMargin, multiplier: 1.0, constant: 8.0).isActive = true
      
      //NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .leadingMargin, multiplier: 1.0, constant: 8.0).isActive = true
   }

   
   var borderColor:UIColor {
      get {
         if let borderColor = self._borderColor {
            return borderColor
         } else {
            return UIBalloonLabelLabel.getDefaultBorderColor()
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
            return UIBalloonLabelLabel.getDefaultLineWidth()
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
            return UIBalloonLabelLabel.getDefaultArrowWidth()
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
            return UIBalloonLabelLabel.getDefaultArrowHeight()
         }
      }
      
      set {
         self._arrowHeight = newValue
      }
   }
   
   override open func draw(_ rect: CGRect) {
      super.draw(rect)
      drawBorder(rect)
   }

   func drawBorder(_ rect: CGRect) {
      /*
      let startingPointLeft = CGPoint(x: rect.minX, y: rect.minY)
      let endingPointLeft = CGPoint(x: rect.minX, y: rect.maxY)
      
      let startingPointBottom = CGPoint(x: rect.minX, y: rect.maxY)
      let endingPointBottom = CGPoint(x: rect.maxX, y: rect.maxY)
      
      let startingPointRight = CGPoint(x: rect.maxX, y: rect.minY)
      let endingPointRight = CGPoint(x: rect.maxX, y: rect.maxY)
      
      let path = UIBezierPath()
      
      // Left
      path.move(to: startingPointLeft)
      path.addLine(to: endingPointLeft)
      
      // Bottom
      path.move(to: startingPointBottom)
      path.addLine(to: endingPointBottom)
      
      // Right
      path.move(to: startingPointRight)
      path.addLine(to: endingPointRight)
      
      path.lineWidth = self.lineWidth
      
      let color:UIColor = self.borderColor
      color.setStroke()
      
      path.stroke()
      */
   }
}
