//
//  UIBalloonLabel.swift
//  Sandbox
//
//  Created by Gene M. Angelo  Jr. on 12/8/16.
//  Copyright © 2016 Mohojo Werks LLC. All rights reserved.
//

import UIKit

@IBDesignable class UIBalloonLabel: UIView, BalloonLabelProtocol {
      
   // MARK: Properties
   fileprivate var _lineWidth:CGFloat?
   fileprivate var _borderColor:UIColor?
   
   fileprivate var _arrowWidth:CGFloat?
   fileprivate var _arrowHeight:CGFloat?
   
   fileprivate var view: UIView!
   fileprivate let nibName: String = "UIBalloonLabel"
      
      
   override init(frame: CGRect) {
      // properties
         
      super.init(frame: frame)
         
      // Set anything that uses view or visible bounds
      setup()
   }
      
   required init(coder aDecoder: NSCoder) {
      // properties
         
      super.init(coder: aDecoder)!
         
      // Setup
      setup()
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
   
   fileprivate func setup() {
      view = loadViewFromNib()
         
      view.frame = bounds
      view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
         
      addSubview(view)
   }
      
   fileprivate func loadViewFromNib() -> UIView? {
      let bundle = Bundle(for: type(of: self))
         
      if let view = bundle.loadNibNamed(self.nibName, owner: self, options: nil)?.first as? UIView {
         return view
      } else {
         return nil
      }
   }
   
   override open func draw(_ rect: CGRect) {
      super.draw(rect)
      drawBorder(rect)
   }
   
   func drawBorder(_ rect: CGRect) {
   }
}
