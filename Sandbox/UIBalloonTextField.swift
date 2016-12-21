//
//  UIBalloonTextField.swift
//
//  Created by Gene M. Angelo  Jr. on 9/11/16.
//  Copyright © 2016 Mohojo Werks LLC. All rights reserved.
//
import UIKit

@IBDesignable public class UIBalloonTextField : UITextField, BalloonProtocol {
   fileprivate var _balloonCornerRadius:Int = 5
   fileprivate var _balloonBorderWidth:CGFloat = 0.5
   fileprivate var _balloonBorderColor:UIColor = UIColor.black
   fileprivate var _balloonArrowSize:CGSize = CGSize(width: 16.0, height: 16.0)
   fileprivate var _balloonBackgroundColor:UIColor = UIColor.white
   
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

      // Remove any previous error balloons that have been displayed.
      let oldErrorBalloon = self.superview?.subviews.filter{ $0 is UIErrorBalloon }
      if oldErrorBalloon != nil {
         oldErrorBalloon?.first?.removeFromSuperview()
      }
      
      // Create the error balloon for displaying errors.
      // let balloonFrame = self.frame.offsetBy(dx: 0, dy: self.frame.height + 1)
      //
      // let balloonFrame = self.frame.offsetBy(dx: 0, dy: self.frame.height + 1)
      
      let balloonFrame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.height + 1, width: self.frame.width, height: self.frame.height + self.balloonArrowSize.height)
 
      let errorBalloon = UIErrorBalloon(frame: balloonFrame, balloonCornerRadius: self.balloonCornerRadius, balloonBorderWidth: self.balloonBorderWidth, balloonArrowSize: self.balloonArrowSize, balloonBorderColor: self.balloonBorderColor, balloonBackgroundColor: self.balloonBackgroundColor)
      // This sets the color behind the balloon, so that the actuall balloon can be seen 
      // propoerly against the control background.
      errorBalloon.backgroundColor = self.superview?.backgroundColor
      
      //
      //errorBalloon.layer.borderColor = UIColor.green.cgColor
      //errorBalloon.layer.borderWidth = 1.0
      
      // Add the error balloon to the superview.
      self.superview?.addSubview(errorBalloon)
      setErrorBalloonConstraints(errorBalloon: errorBalloon)
      
      // Create the error label that is used to display the error message inside
      // the balloon.
      var labelFrame = self.frame.offsetBy(dx: 0, dy: self.frame.height)
      labelFrame.origin.y = labelFrame.origin.y + self.balloonArrowSize.height

      let errorLabel = UIBalloonLabel(frame: labelFrame)
      //errorLabel.layer.borderColor = UIColor.brown.cgColor
      //errorLabel.layer.borderWidth = 1.0
      // TODO: Make font size dynamic.
      errorLabel.font = errorLabel.font.withSize(10.0)
      errorBalloon.addSubview(errorLabel)
      setErrorLabelConstraints(errorLabel: errorLabel, errorBalloon: errorBalloon)
      
      // Set text after adding it to the balloon so that the balloon resizes properly
      errorLabel.text = error
   }
   
   func setErrorLabelConstraints(errorLabel:UIBalloonLabel, errorBalloon:UIErrorBalloon) {
      let margin:CGFloat = 8
      /*
      let topMargin = self.balloonArrowSize.height
      
      // Leading...
      let leading = NSLayoutConstraint(item: errorLabel, attribute: .leading, relatedBy: .equal, toItem: errorBalloon, attribute: .leading, multiplier: 1, constant: margin)
      
      // Trailing...
      let trailing = NSLayoutConstraint(item: errorLabel, attribute: .trailing, relatedBy: .equal, toItem: errorBalloon, attribute: .trailing, multiplier: 1, constant: margin)
      
      // Top...
      let top = NSLayoutConstraint(item: errorLabel, attribute: .top, relatedBy: .equal, toItem: errorBalloon, attribute: .top, multiplier: 1, constant: topMargin)
      
      // Bottom...
      let bottom = NSLayoutConstraint(item: errorLabel, attribute: .bottom, relatedBy: .equal, toItem: errorBalloon, attribute: .bottom, multiplier: 1, constant: margin)
      */
      
      errorBalloon.layoutMargins.top = margin
      errorBalloon.layoutMargins.bottom = margin
      errorBalloon.layoutMargins.left = 0
      errorBalloon.layoutMargins.right = 0
      return
      
      // Leading...
      let leading = NSLayoutConstraint(item: errorLabel, attribute: .leftMargin, relatedBy: .equal, toItem: errorBalloon, attribute: .leftMargin, multiplier: 1, constant: 0)
      
      // Trailing...
      let trailing = NSLayoutConstraint(item: errorLabel, attribute: .rightMargin, relatedBy: .equal, toItem: errorBalloon, attribute: .rightMargin, multiplier: 1, constant: 0)
      
      // Top...
      let top = NSLayoutConstraint(item: errorLabel, attribute: .topMargin, relatedBy: .equal, toItem: errorBalloon, attribute: .topMargin, multiplier: 1, constant: 0)
      
      // Bottom...
      let bottom = NSLayoutConstraint(item: errorLabel, attribute: .bottomMargin, relatedBy: .equal, toItem: errorBalloon, attribute: .bottomMargin, multiplier: 1, constant: 0)

      
      errorLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([leading, trailing, top, bottom])
   }
   
   func setErrorBalloonConstraints(errorBalloon:UIErrorBalloon) {
      let margin:CGFloat = 8
      
      errorBalloon.layoutMargins.top = self.balloonArrowSize.height
      errorBalloon.layoutMargins.bottom = 8
      errorBalloon.layoutMargins.left = 8
      errorBalloon.layoutMargins.right = 8
      
      return
      
      let left = NSLayoutConstraint(item: errorBalloon, attribute: .leftMargin, relatedBy: .equal, toItem: errorBalloon, attribute: .notAnAttribute, multiplier: 1, constant: margin)
      
      let right = NSLayoutConstraint(item: errorBalloon, attribute: .rightMargin, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: margin)

      let top = NSLayoutConstraint(item: errorBalloon, attribute: .topMargin, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: margin)
      
      let bottom = NSLayoutConstraint(item: errorBalloon, attribute: .bottomMargin, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: margin)
      
      errorBalloon.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([left, right, top, bottom])
   }
   
   func clearError() {
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
   
   @IBInspectable var balloonBackgroundColor:UIColor {
      get {
         return self._balloonBackgroundColor
      }
      set {
         self._balloonBackgroundColor = newValue
      }
   }
   
   // BalloonProtocol - end
}


