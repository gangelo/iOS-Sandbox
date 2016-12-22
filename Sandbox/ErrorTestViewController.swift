//
//  ErrorTestViewController.swift
//  Sandbox
//
//  Created by Gene M. Angelo  Jr. on 12/7/16.
//  Copyright © 2016 Mohojo Werks LLC. All rights reserved.
//

import UIKit
//import Foundation

class ErrorTestViewController: ViewController {
   
   fileprivate var _errorMessageIndex:Int = 0
   fileprivate var _errorMessages = [String]()
   
   //@IBOutlet weak var errorBalloon: UIErrorBalloon!
   //@IBOutlet weak var errorLabel: UIBalloonLabel!
   
   @IBOutlet weak var fullName: UIBalloonTextField!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
      
      //self.errorBalloon.isHidden = true
      
      self._errorMessages.append("Short error message")
      self._errorMessages.append("Medium error message XXX XXX XXX")
      self._errorMessages.append("Long error message XXX XXX XXX XXX XXX XXX XXX XXX XXX")
      self._errorMessages.append("Longer error message X X X X X X X X X X X X X X X X X X X X X X X X X X X")
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }

   @IBAction func onShowErrorPressed(_ sender: Any) {
      self.fullName.setError(error: self._errorMessages[self._errorMessageIndex])
      //self.errorBalloon.isHidden = false
      //self.errorLabel.text = self._errorMessages[self._errorMessageIndex]
      
      self._errorMessageIndex += 1
      if (self._errorMessageIndex == self._errorMessages.count) {
         self._errorMessageIndex = 0
      }
      
      /*
      let image = UIImage(named: "error")
      image.frame = CGRect(CGRect(x: 0, y: 0, width: 12, height: 12))
      
      let imageView = UIImageView(image: image!)
      imageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
      errorBalloon.setError(textField: fullName, imageView: imageView, error: "")
      */
   }
   
   @IBAction func onHideErrorPressed(_ sender: Any) {
      //self.errorBalloon.isHidden = true
      //let rect = CGRect(x: self.errorBalloon.frame.origin.x, y: self.errorBalloon.frame.origin.y, width: self.errorBalloon.frame.width, height: 1)
      //self.errorBalloon.frame = rect
      
      
      //self.errorLabel.text = ""
      
      self.fullName.clearError()
   }
}
