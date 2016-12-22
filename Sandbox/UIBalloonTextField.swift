//
//  UIBalloonTextField.swift
//
//  Created by Gene M. Angelo  Jr. on 9/11/16.
//  Copyright © 2016 Mohojo Werks LLC. All rights reserved.
//
import UIKit

@IBDesignable public class UIBalloonTextField : UITextField {
   fileprivate var _errorView:UIView?
   fileprivate var _successView:UIView?
   
   override init(frame: CGRect) {
      super.init(frame: frame)
   }

   
   required public init(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)!
   }
   
   @IBInspectable var errorImage:UIImage? = nil {
      didSet {
         // self.setErrorImage()
      }
   }
   
   func setError(error:String) {
      self.clearError()
      //self.clearErrorImage()
      
      self.setErrorImage()
      
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
   
   fileprivate func setErrorImage() {
      if (self.errorImage == nil) {
         return
      }
      
      let imageView = UIImageView(image: self.errorImage)
      imageView.frame = CGRect(x: 0, y: 0, width: 12, height: 12)
      attachTapGesture(imageView: imageView)
      self._errorView = UIView()
      self._errorView?.addSubview(imageView)
      self._errorView?.frame = CGRect(x: 0, y: 0, width: 18, height: 12)
      
      self.rightView = self._errorView
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
   
   func clearError() {
      // Remove any previous error balloons that have been displayed.
      let errorBalloon = self.superview?.subviews.filter{ $0 is UIErrorBalloon }
      if errorBalloon != nil {
         errorBalloon?.first?.removeFromSuperview()
      }
      
      // Remove the error image on the textfield
      if let errorView = self._errorView {
         errorView.subviews.first?.removeFromSuperview()
      }
   }
   
   func attachTapGesture(imageView:UIImageView) {
      let tap = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
      tap.numberOfTapsRequired = 1
      imageView.isUserInteractionEnabled = true
      imageView.addGestureRecognizer(tap)
   }
   
   func tap(_ gestureRecognizer: UITapGestureRecognizer) {
      self.clearError()
   }
   
   override public func draw(_ rect: CGRect) {
      super.draw(rect)
   }
}


