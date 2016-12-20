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
   var cornerRadius:Int { get set }
   var lineWidth:CGFloat { get set }
   var strokeColor:UIColor { get set }
   var arrowSize:CGSize { get set }
}
