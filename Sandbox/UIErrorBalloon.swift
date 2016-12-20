//
//  UIErrorBalloon.swift
//  Accumoo
//
//  Created by Gene M. Angelo  Jr. on 12/10/16.
//  Copyright © 2016 Mohojo Werks LLC. All rights reserved.
//

import UIKit
import Foundation

@IBDesignable class UIErrorBalloon: UIBalloon {
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      self.initialize()
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      
      self.initialize()
   }
   
   internal override func initialize() {
      super.initialize()
      self.strokeColor = UIColor.red
   }
}
