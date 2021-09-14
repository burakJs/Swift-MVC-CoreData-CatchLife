//
//  UIButtonExtension.swift
//  CatchLife
//
//  Created by Burak İmdat on 10.09.2021.
//

import Foundation
import UIKit

extension UIButton {
    func selectedButtonBGColor(){
        self.backgroundColor = #colorLiteral(red: 0, green: 0.500575006, blue: 1, alpha: 1)
    }
    
    func nonSelectedButtonBGColor(){
        self.backgroundColor = #colorLiteral(red: 0, green: 0.2792959213, blue: 0.5974427462, alpha: 1)
    }
}

