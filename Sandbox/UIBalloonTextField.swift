//
//  UIBalloonTextField.swift
//
//  Created by Gene M. Angelo  Jr. on 9/11/16.
//  Copyright © 2016 Mohojo Werks LLC. All rights reserved.
//
import UIKit

@IBDesignable public class UIBalloonTextField : UITextField {
   fileprivate var _imageView:UIView?
   
   override init(frame: CGRect) {
      super.init(frame: frame)
   }

   
   required public init(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)!
   }
   
   @IBInspectable var successImage:UIImage? = nil
   @IBInspectable var errorImage:UIImage? = nil
   @IBInspectable var waitingImage:UIImageView? = nil
   
   func setWaiting() {
      self.clear()
      
      let imageView:UIImageView = UIImageView() //(rect: CGRect(x: 0, y: 0, width: 12, height: 12))
      imageView.animationImages = [
         UIImage(named: "waiting_0")!,
         UIImage(named: "waiting_1")!,
         UIImage(named: "waiting_2")!,
         UIImage(named: "waiting_3")!,
         UIImage(named: "waiting_4")!,
         UIImage(named: "waiting_5")!,
         UIImage(named: "waiting_6")!,
         UIImage(named: "waiting_7")!,
         UIImage(named: "waiting_8")!,
         UIImage(named: "waiting_9")!,
         UIImage(named: "waiting_10")!,
         UIImage(named: "waiting_11")!]
      imageView.animationDuration = 1.0;
      imageView.animationRepeatCount = 0;
      //[animatedImageView startAnimating];
      //[self.view addSubview: animatedImageView];
      self.setImage(imageView: imageView)
      
      imageView.startAnimating()
   }
   
   func setSuccess() {
      self.clear()
      self.setImage(image: successImage)
   }
   
   func setError(error:String) {
      self.clear()
      
      self.setImage(image: errorImage)
      
      // Create the error balloon for displaying errors.
      let errorBalloon = UIErrorBalloon(frame: self.frame)
      errorBalloon.setFrame(balloonTextField: self)
      
      // This sets the color behind the balloon, so that the actuall balloon can be seen propoerly against the control background. 
      // errorBalloon.backgroundColor = self.superview?.backgroundColor
      errorBalloon.backgroundColor = UIColor.clear
      
      // Add the error balloon to the superview.
      self.superview?.addSubview(errorBalloon)
      
      // Create the error label that is used to display the error message inside
      // the balloon.
      var labelFrame = self.frame.offsetBy(dx: 0, dy: self.frame.height)
      labelFrame.origin.y = labelFrame.origin.y + errorBalloon.balloonArrowSize.height

      let errorLabel = UIBalloonLabel(frame: labelFrame, textColor: errorBalloon.balloonTextColor, fontSize: errorBalloon.balloonFontSize)
      errorBalloon.addSubview(errorLabel)
      setErrorLabelConstraints(errorLabel: errorLabel, errorBalloon: errorBalloon)
      
      // Set text after adding it to the balloon so that the balloon resizes properly
      errorLabel.text = error
   }
   
   fileprivate func setImage(image:UIImage?) {
      if (image == nil) {
         return
      }
      
      let imageView = UIImageView(image: image)
      self.setImage(imageView: imageView)
      
      /*
      imageView.frame = CGRect(x: 0, y: 0, width: 12, height: 12)
      attachTapGesture(imageView: imageView)
      self._imageView = UIView()
      self._imageView?.addSubview(imageView)
      self._imageView?.frame = CGRect(x: 0, y: 0, width: 18, height: 12)
      
      self.rightView = self._imageView
      self.rightViewMode = .always
      */
   }
   
   fileprivate func setImage(imageView:UIImageView) {
      imageView.frame = CGRect(x: 0, y: 0, width: 12, height: 12)
      attachTapGesture(imageView: imageView)
      self._imageView = UIView()
      self._imageView?.addSubview(imageView)
      self._imageView?.frame = CGRect(x: 0, y: 0, width: 18, height: 12)
      
      self.rightView = self._imageView
      self.rightViewMode = .always
   }
   
   func setErrorLabelConstraints(errorLabel:UIBalloonLabel, errorBalloon:UIErrorBalloon) {
      // Leading...
      let leading = NSLayoutConstraint(item: errorLabel, attribute: .leftMargin, relatedBy: .equal, toItem: errorBalloon, attribute: .leftMargin, multiplier: 1, constant: errorBalloon.layoutMargins.left)
      
      // Trailing...
      let trailing = NSLayoutConstraint(item: errorLabel, attribute: .rightMargin, relatedBy: .equal, toItem: errorBalloon, attribute: .rightMargin, multiplier: 1, constant: errorBalloon.layoutMargins.right)
      
      // Top...
      let top = NSLayoutConstraint(item: errorLabel, attribute: .topMargin, relatedBy: .equal, toItem: errorBalloon, attribute: .topMargin, multiplier: 1, constant: errorBalloon.layoutMargins.top + errorBalloon.balloonArrowSize.height)
      
      errorLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([leading, trailing, top])
   }
   
   func clear() {
      // Remove any previous error balloons that have been displayed.
      if let balloon = self.superview?.subviews.filter({ $0 is UIBalloonBase }) {
         balloon.first?.removeFromSuperview()
      }
      
      // Remove the image attached to the textfield
      if let imageView = self._imageView {
         imageView.subviews.first?.removeFromSuperview()
      }
   }
   
   func attachTapGesture(imageView:UIImageView) {
      let tap = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
      tap.numberOfTapsRequired = 1
      imageView.isUserInteractionEnabled = true
      imageView.addGestureRecognizer(tap)
   }
   
   func tap(_ gestureRecognizer: UITapGestureRecognizer) {
      self.clear()
   }
   
   override public func draw(_ rect: CGRect) {
      super.draw(rect)
   }
}


