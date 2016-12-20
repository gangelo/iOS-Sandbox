//
//  UIBalloon.swift
//  Accumoo
//
//  Created by Gene M. Angelo  Jr. on 12/10/16.
//  Copyright © 2016 Mohojo Werks LLC. All rights reserved.
//

import UIKit
import Foundation

@IBDesignable class UIBalloon: UIView, BalloonProtocol {
   fileprivate var _cornerRadius:Int = 0
   fileprivate var _lineWidth:CGFloat = 0.0
   fileprivate var _strokeColor:UIColor = UIColor.black
   fileprivate var _arrowSize:CGSize = CGSize.zero
   fileprivate var _balloonBackgroundColor:UIColor = UIColor.white
   
   convenience init(frame:CGRect, cornerRadius:Int, lineWidth:CGFloat, strokeColor:UIColor, balloonBackgroundColor:UIColor) {
      self.init(frame: frame)
      
      self._cornerRadius = cornerRadius
      self._lineWidth = lineWidth
      self._strokeColor = strokeColor
      self._balloonBackgroundColor = balloonBackgroundColor
      
      self.initialize()
   }
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      self.initialize()
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      self.initialize()
   }
   
   internal func initialize() {
   }
   
   // MARK: - BalloonProtocol - start
   
   @IBInspectable var cornerRadius:Int {
      get {
         return self._cornerRadius
      }
      set {
         self._cornerRadius = newValue
      }
   }
   
   @IBInspectable var lineWidth:CGFloat {
      get {
         return self._lineWidth
      }
      set {
         self._lineWidth = newValue
      }
   }
   
   @IBInspectable var strokeColor:UIColor {
      get {
         return self._strokeColor
      }
      set {
         self._strokeColor = newValue
      }
   }
   
   @IBInspectable var arrowSize:CGSize {
      get {
         return self._arrowSize
      }
      set {
         self._arrowSize = newValue
      }
   }
   
   @IBInspectable var balloonBackgroundColor:UIColor {
      get {
         return self._balloonBackgroundColor
      }
      set {
         self._balloonBackgroundColor = newValue
      }
   }
   
   // BalloonProtocol - end
   
   func clearAndHide() {
      let balloonLabel = self.subviews.first as! UIBalloonLabel
      self.isHidden = true
      balloonLabel.text = ""
   }
   
   fileprivate func getAdjustedBorderRect(rect: CGRect) -> CGRect {
      var adjustedRect = CGRect(origin: CGPoint(x: rect.origin.x, y: rect.origin.y), size: CGSize(width: rect.width, height: rect.height))
      
      adjustedRect.origin.x = self._lineWidth
      adjustedRect.origin.y = self._lineWidth + self._arrowSize.height
      adjustedRect.size.width = (frame.size.width - (self._lineWidth * 2))
      adjustedRect.size.height = (frame.size.height - (self._lineWidth * 2)) - self._arrowSize.height
      
      return adjustedRect
   }
   
   override func draw(_ rect: CGRect) {
      let adjustedRect = getAdjustedBorderRect(rect: rect)
      
      // Box
      self._strokeColor.setStroke()
      self._balloonBackgroundColor.setFill()
      
      var path = UIBezierPath(roundedRect: adjustedRect, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: self._cornerRadius, height: self._cornerRadius))
      path.lineWidth = self._lineWidth
      
      path.fill()
      
      path.stroke()
      
      
      // Erase
      self.backgroundColor?.setStroke()
      
      path = UIBezierPath()
      path.move(to: CGPoint(x: (self.frame.size.width / 2) - (self.arrowSize.width / 2), y: self.lineWidth))
      path.addLine(to: CGPoint(x: (self.frame.size.width / 2) + (self.arrowSize.width / 2), y: self.lineWidth))
      path.lineWidth = self.lineWidth
      path.stroke()
      
      // Arrow
      self.backgroundColor?.setStroke()
      
      path = UIBezierPath()
      
      // Erase the portion of the balloon where the base of the arrow will go
      path.move(to: CGPoint(x: (adjustedRect.size.width / 2) - (self.arrowSize.width / 2), y: adjustedRect.origin.y))
      path.addLine(to: CGPoint(x: (adjustedRect.size.width / 2) + (self.arrowSize.width / 2), y: adjustedRect.origin.y))
      path.lineWidth = self.lineWidth * 2
      path.stroke()
      
      
      // Draw the arrow point
      self.strokeColor.setStroke()
      
      path = UIBezierPath()
      
      // Arrow left side
      path.move(to: CGPoint(x: (adjustedRect.size.width / 2) - (self.arrowSize.width / 2), y: adjustedRect.origin.y))
      path.addLine(to: CGPoint(x: (adjustedRect.size.width / 2), y: adjustedRect.origin.y - self.arrowSize.height))
      
      // Arrow right side
      path.move(to: CGPoint(x: (adjustedRect.size.width / 2) + (self.arrowSize.width / 2), y: adjustedRect.origin.y))
      path.addLine(to: CGPoint(x: (adjustedRect.size.width / 2), y: adjustedRect.origin.y - self.arrowSize.height))
      
      path.lineWidth = self.lineWidth
      
      path.stroke()
   }
   
   func resizeToFitSubviews() {
      let balloonLabel = self.subviews.first as! UIBalloonLabel
      let balloonLabelHeight: CGFloat = balloonLabel.frame.height
      
      let newBalloonHeight = balloonLabelHeight + (self.arrowSize.height + self.layoutMargins.top + self.layoutMargins.bottom)
      
      self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: newBalloonHeight)
      
      repositionBalloonLabel(balloonLabel: balloonLabel)
      
      self.setNeedsDisplay()
   }
   
   fileprivate func repositionBalloonLabel(balloonLabel: UIBalloonLabel) {
      let newCenterY = self.frame.height / 2 - (balloonLabel.frame.height / 2)
      balloonLabel.frame.origin.y = newCenterY
   }
}

