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


let view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 320))
PlaygroundPage.current.liveView = view

var circle = Circle(radius: 50, color: UIColor.blue)
circle.center = CGPoint(x: 100, y: 100)

view.addSubview(circle)



