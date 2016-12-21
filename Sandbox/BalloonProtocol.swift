//
//  BalloonProtocol.swift
//  Sandbox
//
//  Created by Gene M. Angelo  Jr. on 12/16/16.
//  Copyright © 2016 Mohojo Werks LLC. All rights reserved.
//

import UIKit
import Foundation

protocol BalloonProtocol {
   var balloonBackgroundColor:UIColor { get set }
   var balloonCornerRadius:Int { get set }
   var balloonBorderWidth:CGFloat { get set }
   var balloonBorderColor:UIColor { get set }
   var balloonArrowSize:CGSize { get set }
}
