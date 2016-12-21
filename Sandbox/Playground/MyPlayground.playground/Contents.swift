//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
import PlaygroundSupport

var hex:Int = 0xCC0000

extension UIColor {
   
   convenience init(red: Int, green: Int, blue: Int) {
      assert(red >= 0 && red <= 255, "Invalid red component")
      assert(green >= 0 && green <= 255, "Invalid green component")
      assert(blue >= 0 && blue <= 255, "Invalid blue component")
      
      self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }
   
   // Usage: UIColor(0xFFFFFF)
   convenience init(hex: Int) {
      self.init(red: (hex >> 16) & 0xff, green: (hex >> 8) & 0xff, blue: hex & 0xff)
   }
}


let color = UIColor(hex: 0xcc0000)


/*
class Shape : UIView {
   var color:UIColor
   
   init(color:UIColor) {
      self.color = color
      super.init(frame: CGRect.zero)
      self.backgroundColor = color
      setFrameSize()
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   func setFrameSize() {
      self.frame.size = CGSize.zero
   }
   
   func getArea() -> Double {
      return 0;
   }
}

//
// Circle
class Circle : Shape {
   var radius:Int
   
   init(radius:Int, color:UIColor) {
      self.radius = radius
      super.init(color: color)
      self.layer.cornerRadius = CGFloat(radius)
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   override func setFrameSize() {
      self.frame.size = CGSize(width: radius * 2, height: radius * 2)
   }
   
   override func getArea() -> Double {
      let power = Double(pow(Double(radius), Double(2)))
      return (Double(M_PI * power))
   }
}
*/

class Shape : UIView {
   var color:UIColor
   
   init(color:UIColor) {
      self.color = color
      super.init(frame: CGRect.zero)
      self.backgroundColor = color
      setFrameSize()
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   func setFrameSize() {
      self.frame.size = CGSize.zero
   }
   
   func getArea() -> Double {
      return 0;
   }
}


class UIBalloon: Shape {
   fileprivate var size:CGSize
   fileprivate var cornerRadius:Int
   fileprivate var lineWidth:CGFloat
   fileprivate var strokeColor:UIColor
   
   fileprivate var arrowSize:CGSize = CGSize(width: 16.0, height: 8.0)
   
   init(size:CGSize, cornerRadius:Int, lineWidth:CGFloat, backgroundColor:UIColor, strokeColor:UIColor) {
      self.size = size
      self.cornerRadius = cornerRadius
      self.lineWidth = lineWidth
      self.strokeColor = strokeColor
      
      super.init(color: backgroundColor)
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   override func setFrameSize() {
      self.frame.size = self.size
   }
   
   fileprivate func getAdjustedBorderRect(rect: CGRect) -> CGRect {
      var adjustedRect = CGRect(origin: CGPoint(x: rect.origin.x, y: rect.origin.y), size: CGSize(width: rect.width, height: rect.height))
      
      adjustedRect.origin.x = self.lineWidth
      adjustedRect.origin.y = self.lineWidth + self.arrowSize.height
      adjustedRect.size.width = (frame.size.width - (self.lineWidth * 2))
      adjustedRect.size.height = (frame.size.height - (self.lineWidth * 2)) - self.arrowSize.height
      
      return adjustedRect
   }
   
   override func draw(_ rect: CGRect) {
      let adjustedRect = getAdjustedBorderRect(rect: rect)
      
      // Box
      self.strokeColor.setStroke()
      
      var path = UIBezierPath(roundedRect: adjustedRect, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: self.cornerRadius, height: self.cornerRadius))
      path.lineWidth = self.lineWidth
      path.stroke()
      
      
      // Erase
      self.backgroundColor?.setStroke()
      
      path = UIBezierPath()
      path.move(to: CGPoint(x: (self.size.width / 2) - (self.arrowSize.width / 2), y: self.lineWidth))
      path.addLine(to: CGPoint(x: (self.size.width / 2) + (self.arrowSize.width / 2), y: self.lineWidth))
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
}


let view = UIView(frame: CGRect(x: 0, y: 0, width: 640, height: 640))
view.backgroundColor = UIColor.white
PlaygroundPage.current.liveView = view

let balloon = UIBalloon(size: CGSize(width: 225, height: 45), cornerRadius: 5, lineWidth: 1.0, backgroundColor: UIColor.white, strokeColor: UIColor.red)
balloon.center = CGPoint(x: 320.0, y: 320.0)

view.addSubview(balloon)


