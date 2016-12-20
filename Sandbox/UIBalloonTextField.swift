//
//  UIBalloonTextField.swift
//
//  Created by Gene M. Angelo  Jr. on 9/11/16.
//  Copyright © 2016 Mohojo Werks LLC. All rights reserved.
//
import UIKit

@IBDesignable public class UIBalloonTextField : UITextField, BalloonProtocol {
   fileprivate var _cornerRadius:Int = 5
   fileprivate var _lineWidth:CGFloat = 0.5
   fileprivate var _strokeColor:UIColor = UIColor.red
   fileprivate var _arrowSize:CGSize = CGSize(width: 16.0, height: 16.0)
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
      
      let balloonFrame = self.frame.offsetBy(dx: 0, dy: self.frame.height + 1)
      
      let errorBalloon = UIErrorBalloon(frame: balloonFrame, cornerRadius: self.cornerRadius, lineWidth: self.lineWidth, strokeColor: self.strokeColor, balloonBackgroundColor: self._balloonBackgroundColor)
      errorBalloon.backgroundColor = self.superview?.backgroundColor

      
      //
      let oldErrorBalloon = self.superview?.subviews.filter{ $0 is UIErrorBalloon }
      if oldErrorBalloon != nil {
         oldErrorBalloon?.first?.removeFromSuperview()
      }
      
      //
      self.superview?.addSubview(errorBalloon)
      
      var labelFrame = self.frame.offsetBy(dx: 0, dy: self.frame.height)
      labelFrame.origin.y = labelFrame.origin.y + self.arrowSize.height

      let errorLabel = UIBalloonLabel(frame: labelFrame)
      errorLabel.font = errorLabel.font.withSize(12.0)
      errorBalloon.addSubview(errorLabel)
      
      // Set text after adding it to the balloon so that the balloon resizes properly
      errorLabel.text = error
      
      errorBalloon.resizeToFitSubviews()
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
   
   @IBInspectable var cornerRadius:Int {
      get {
         return self._cornerRadius
      }
      set {
         self._cornerRadius = newValue
      }
   }
   
   @IBInspectable var lineWidth:CGFloat {
      get {
         return self._lineWidth
      }
      set {
         self._lineWidth = newValue
      }
   }
   
   @IBInspectable var strokeColor:UIColor {
      get {
         return self._strokeColor
      }
      set {
         self._strokeColor = newValue
      }
   }
   
   @IBInspectable var arrowSize:CGSize {
      get {
         return self._arrowSize
      }
      set {
         self._arrowSize = newValue
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


