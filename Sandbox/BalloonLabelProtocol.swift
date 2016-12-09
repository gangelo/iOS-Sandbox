//
//  BalloonLabelProtocol.swift
//  Sandbox
//
//  Created by Gene M. Angelo  Jr. on 12/8/16.
//  Copyright © 2016 Mohojo Werks LLC. All rights reserved.
//

import UIKit
import Foundation

protocol BalloonLabelProtocol {
   
   // Get/set the border color of the balloon
   var borderColor:UIColor { get set }
   
   // Get/set the line width of the balloon
   var lineWidth:CGFloat  { get set }
   
   // The width of the balloon arrow
   var arrowWidth:CGFloat { get set }
   
   // The height of the balloon arrow
   var arrowHeight:CGFloat { get set }
   
   //
   // Implement and call this method to draw the border
   // when draw is called. 
   //
   // Example:
   //
   // override public func draw(_ rect: CGRect) {
   //    super.draw(rect)
   //    drawBorder(rect: rect)
   // }
   //
   func drawBorder(rect: CGRect)
}

extension BalloonLabelProtocol {
   static func getDefaultBorderColor() -> UIColor {
      return UIColor.red
   }
   
   static func getDefaultLineWidth() -> CGFloat {
      return 1.0
   }
   
   static func getDefaultArrowWidth() -> CGFloat {
      return 16.0
   }
   
   static func getDefaultArrowHeight() -> CGFloat {
      return getDefaultArrowWidth() / 2
   }
}
