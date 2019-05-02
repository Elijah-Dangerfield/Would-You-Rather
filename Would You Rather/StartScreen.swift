//
//  StartScreen.swift
//  Would You Rather
//
//  Created by eli dangerfield on 5/1/19.
//  Copyright © 2019 eli dangerfield. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
import Firebase

class startScreen: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }

}
