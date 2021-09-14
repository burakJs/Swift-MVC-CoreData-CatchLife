//
//  UIViewExtension.swift
//  CatchLife
//
//  Created by Burak İmdat on 10.09.2021.
//

import Foundation
import UIKit

extension UIView {
    func keyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardChange(_ notification: NSNotification) {
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let firstKeyboardFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let lastKeyboardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let differenceY = lastKeyboardFrame.origin.y - firstKeyboardFrame.origin.y
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: KeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += differenceY
        }, completion: nil)
    }
}
