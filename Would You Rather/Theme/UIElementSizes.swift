//
//  UIElementSizes.swift
//  Would You Rather
//
//  Created by eli dangerfield on 5/30/19.
//  Copyright © 2019 eli dangerfield. All rights reserved.
//

import Foundation
import UIKit

struct UIElementSizes {

    static var windowWidth: CGFloat = UIScreen.main.bounds.width
    static var windowHeight: CGFloat = UIScreen.main.bounds.height
    //initialized to zero, changed in first viewDidLoad()
    static var navigationBarHeight: CGFloat = 0
    
    static var buttonWidth: CGFloat = windowWidth/1.5
}
