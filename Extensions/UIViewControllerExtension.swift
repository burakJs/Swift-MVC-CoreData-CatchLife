//
//  UIViewControllerExtension.swift
//  CatchLife
//
//  Created by Burak İmdat on 10.09.2021.
//

import Foundation
import UIKit

extension UIViewController {
    func presentCustom(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.6
        transition.type = .push
        transition.subtype = .fromRight
        self.view.window?.layer.add(transition, forKey: "presentAnimation")
        present(viewControllerToPresent, animated: false, completion: nil)
    }
    
    func presentCustomtoHome(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.6
        transition.type = .push
        transition.subtype = .fromRight
        guard let presentedVC = presentedViewController else { return }
        presentedVC.dismiss(animated: false){
            self.view.window?.layer.add(transition, forKey: "presentAnimation2")
            self.present(viewControllerToPresent, animated: false, completion: nil)
        }
    }
    
    func dismissCustom() {
        let transition = CATransition()
        transition.duration = 0.6
        transition.type = .push
        transition.subtype = .fromLeft
        self.view.window?.layer.add(transition, forKey: "dismissAnimation")
        dismiss(animated: false, completion: nil)
    }
}
