//
//  DisplayButton.swift
//  Would You Rather
//
//  Created by eli dangerfield on 4/30/19.
//  Copyright © 2019 eli dangerfield. All rights reserved.
//

import Foundation
import UIKit

class DisplayButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    private func setupButton() {
        //titleLabel?.font    = UIFont(name: Fonts.avenirNextCondensedDemiBold, size: 22)
        layer.borderColor = #colorLiteral(red: 0.4411836407, green: 1, blue: 0.8514406318, alpha: 1)
        layer.borderWidth = 0
        layer.cornerRadius  = 12
        setTitleColor(.white, for: .normal)
    }
}
