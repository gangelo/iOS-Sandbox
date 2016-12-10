//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
import PlaygroundSupport

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

class Corner: Shape {
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
      
      //self.layer.cornerRadius = CGFloat(radius)
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   override func setFrameSize() {
      //self.size.height += self.arrowWidth
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
      var path = UIBezierPath(roundedRect: adjustedRect, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: self.cornerRadius, height: self.cornerRadius))
      
      path.lineWidth = self.lineWidth
      
      
      self.strokeColor.setStroke()
      path.stroke()
      
      //path.close()
      
      // Erase
      path = UIBezierPath()
      
      path.lineWidth = self.lineWidth
      
      
      path.move(to: CGPoint(x: (self.size.width / 2) - (self.arrowSize.width / 2), y: self.lineWidth))
      path.addLine(to: CGPoint(x: (self.size.width / 2) + (self.arrowSize.width / 2), y: self.lineWidth))
      
      self.backgroundColor?.setStroke()
      
      path.stroke()
      
      // Arrow
      path = UIBezierPath()
      
      path.lineWidth = self.lineWidth
      
      // Erase the portion of the balloon where the base of the arrow will go
      path.move(to: CGPoint(x: (adjustedRect.size.width / 2) - (self.arrowSize.width / 2), y: adjustedRect.origin.y))
      path.addLine(to: CGPoint(x: (adjustedRect.size.width / 2) + (self.arrowSize.width / 2), y: adjustedRect.origin.y))
      
      self.backgroundColor?.setStroke()
      
      path.stroke()
      
      // Draw the arrow point
      path = UIBezierPath()
      
      path.lineWidth = self.lineWidth
      
      self.strokeColor.setStroke()
      
      // Arrow left side
      path.move(to: CGPoint(x: (adjustedRect.size.width / 2) - (self.arrowSize.width / 2), y: adjustedRect.origin.y))
      path.addLine(to: CGPoint(x: (adjustedRect.size.width / 2), y: adjustedRect.origin.y - self.arrowSize.height))
      
      // Arrow right side
      path.move(to: CGPoint(x: (adjustedRect.size.width / 2) + (self.arrowSize.width / 2), y: adjustedRect.origin.y))
      path.addLine(to: CGPoint(x: (adjustedRect.size.width / 2), y: adjustedRect.origin.y - self.arrowSize.height))
      
      
      path.stroke()
   }
}


let view = UIView(frame: CGRect(x: 0, y: 0, width: 640, height: 640))
view.backgroundColor = UIColor.white
PlaygroundPage.current.liveView = view

//var circle = Circle(radius: 50, color: UIColor.blue)
//circle.center = CGPoint(x: 100, y: 100)

//view.addSubview(circle)


let corner = Corner(size: CGSize(width: 225, height: 45), cornerRadius: 8, lineWidth: 2.0, backgroundColor: UIColor.white, strokeColor: UIColor.red)
corner.center = CGPoint(x: 320.0, y: 320.0)

view.addSubview(corner)
