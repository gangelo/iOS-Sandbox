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
      self.fullName.setWaiting()
      
      self.runAsyncWithDelay(2, closure: {
         self.fullName.setError(error: self._errorMessages[self._errorMessageIndex])
         
         self._errorMessageIndex += 1
         
         if (self._errorMessageIndex == self._errorMessages.count) {
            self._errorMessageIndex = 0
         }
      })
   }
   
   @IBAction func onHideErrorPressed(_ sender: Any) {
      self.fullName.clear()
   }
   
   @IBAction func onShowSuccess(_ sender: Any) {
      self.fullName.setWaiting()
      
      self.runAsyncWithDelay(2, closure: {
         self.fullName.setSuccess()
      })
   }
   
   // Runs the code in the closure delay seconds from the point of execution, asynchronously.
   func runAsyncWithDelay(_ delay: Double, closure: @escaping ()->()) {
      let when = DispatchTime.now() + delay
      DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
   }
}
