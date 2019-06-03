//
//  button.swift
//  Would You Rather
//
//  Created by eli dangerfield on 4/30/19.
//  Copyright © 2019 eli dangerfield. All rights reserved.
//

import UIKit

class ActionButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        //have to set this here as the height is not known until this callback
        layer.cornerRadius = bounds.height / 2.0
    }
    
    private func setupButton() {
        self.layer.backgroundColor = Colors.lightBlue.cgColor
        self.isExclusiveTouch = true
        self.titleLabel!.font = UIFont(name: "HelveticaNeue", size: 20)
        self.titleLabel?.tintColor = .white
        self.setTitleColor(.white, for: .normal)
    }
}
