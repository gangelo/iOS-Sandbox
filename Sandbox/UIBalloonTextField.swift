//
//  UIBalloonTextField.swift
//
//  Created by Gene M. Angelo  Jr. on 9/11/16.
//  Copyright © 2016 Mohojo Werks LLC. All rights reserved.
//
import UIKit

@IBDesignable public class UIBalloonTextField : UITextField, BalloonProtocol {
   fileprivate var _balloonTextColor:UIColor = UIColor.black
   fileprivate var _balloonFontSize:CGFloat = 10.0
   fileprivate var _balloonBackgroundColor:UIColor = UIColor.clear
   fileprivate var _balloonCornerRadius:Int = 0
   fileprivate var _balloonBorderWidth:CGFloat = 1
   fileprivate var _balloonBorderColor:UIColor = UIColor.black
   fileprivate var _balloonArrowSize:CGSize = CGSize(width: 0, height: 0)
   fileprivate var _balloonArrowPosition = BalloonArrowPosition.center
   
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
         if (self.errorImage != nil) {
            let imageView = UIImageView(image: self.errorImage)
            imageView.frame = CGRect(x: 0, y: 0, width: 12, height: 12)
            attachTapGesture(imageView: imageView)
            self._errorView = UIView()
            self._errorView?.addSubview(imageView)
            self._errorView?.frame = CGRect(x: 0, y: 0, width: 18, height: 12)
         }
      }
   }
   
   func setError(error:String) {
      self.rightView = self._errorView
      self.rightViewMode = .always

      self.clearError()
      
      // Create the error balloon for displaying errors.
      let balloonFrame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.height + 1, width: self.frame.width, height: self.frame.height + self.balloonArrowSize.height)
 
      let errorBalloon = UIErrorBalloon(frame: balloonFrame)
      
      // This sets the color behind the balloon, so that the actuall balloon can be seen 
      // propoerly against the control background.
      errorBalloon.backgroundColor = self.superview?.backgroundColor
      
      // Add the error balloon to the superview.
      self.superview?.addSubview(errorBalloon)
      
      // Create the error label that is used to display the error message inside
      // the balloon.
      var labelFrame = self.frame.offsetBy(dx: 0, dy: self.frame.height)
      labelFrame.origin.y = labelFrame.origin.y + self.balloonArrowSize.height

      let errorLabel = UIBalloonLabel(frame: labelFrame, textColor: self.balloonTextColor, fontSize: 10.0)
      errorBalloon.addSubview(errorLabel)
      setErrorLabelConstraints(errorLabel: errorLabel, errorBalloon: errorBalloon)
      
      // Set text after adding it to the balloon so that the balloon resizes properly
      errorLabel.text = error
   }
   
   func setErrorLabelConstraints(errorLabel:UIBalloonLabel, errorBalloon:UIErrorBalloon) {
      // Leading...
      let leading = NSLayoutConstraint(item: errorLabel, attribute: .leftMargin, relatedBy: .equal, toItem: errorBalloon, attribute: .leftMargin, multiplier: 1, constant: errorBalloon.layoutMargins.left)
      
      // Trailing...
      let trailing = NSLayoutConstraint(item: errorLabel, attribute: .rightMargin, relatedBy: .equal, toItem: errorBalloon, attribute: .rightMargin, multiplier: 1, constant: errorBalloon.layoutMargins.right)
      
      // Top...
      let top = NSLayoutConstraint(item: errorLabel, attribute: .topMargin, relatedBy: .equal, toItem: errorBalloon, attribute: .topMargin, multiplier: 1, constant: errorBalloon.layoutMargins.top + self.balloonArrowSize.height)
      
      errorLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([leading, trailing, top])
   }
   
   func clearError() {
      // Remove any previous error balloons that have been displayed.
      let errorBalloon = self.superview?.subviews.filter{ $0 is UIErrorBalloon }
      if errorBalloon != nil {
         errorBalloon?.first?.removeFromSuperview()
      }
   }
   
   func attachTapGesture(imageView:UIImageView) {
      let tap = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
      tap.numberOfTapsRequired = 1
      imageView.isUserInteractionEnabled = true
      imageView.addGestureRecognizer(tap)
   }
   
   func tap(_ gestureRecognizer: UITapGestureRecognizer) {
      // TODO: Remove error/success view
   }
   
   override public func draw(_ rect: CGRect) {
      super.draw(rect)
   }
   
   // MARK: - BalloonProtocol - start
   
   @IBInspectable var balloonTextColor:UIColor {
      get {
         return self._balloonTextColor
      }
      set {
         self._balloonTextColor = newValue
      }
   }
   
   @IBInspectable var balloonFontSize: CGFloat {
      get {
         return self._balloonFontSize
      }
      set {
         self._balloonFontSize = newValue
      }
   }
   
   @IBInspectable var balloonBackgroundColor:UIColor {
      get {
         return self._balloonBackgroundColor
      }
      set {
         self._balloonBackgroundColor = newValue
      }
   }

   @IBInspectable var balloonCornerRadius:Int {
      get {
         return self._balloonCornerRadius
      }
      set {
         self._balloonCornerRadius = newValue
      }
   }
   
   @IBInspectable var balloonBorderWidth:CGFloat {
      get {
         return self._balloonBorderWidth
      }
      set {
         self._balloonBorderWidth = newValue
      }
   }
   
   @IBInspectable var balloonBorderColor:UIColor {
      get {
         return self._balloonBorderColor
      }
      set {
         self._balloonBorderColor = newValue
      }
   }
   
   @IBInspectable var balloonArrowSize:CGSize {
      get {
         return self._balloonArrowSize
      }
      set {
         self._balloonArrowSize = newValue
      }
   }

   @IBInspectable var balloonArrowPosition: BalloonArrowPosition {
      get {
         return self._balloonArrowPosition
      }
      set {
         self._balloonArrowPosition = newValue
      }
   }

   // BalloonProtocol - end
}


