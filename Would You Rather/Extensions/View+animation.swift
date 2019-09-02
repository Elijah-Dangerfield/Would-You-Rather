//
//  View+animaiton.swift
//  Would You Rather
//
//  Created by eli dangerfield on 9/2/19.
//  Copyright © 2019 eli dangerfield. All rights reserved.
//

import Foundation
import UIKit
extension UIView {

    func animateSlide(inView view: UIView) {
        self.center.x += (view.bounds.width)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            self.center.x -= (view.bounds.width)
            view.layoutIfNeeded()
        }, completion: nil)
    }
}
