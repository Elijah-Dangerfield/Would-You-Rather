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
    
    var isChecked: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    @objc
    func btnClick(sender: DisplayButton){
        
        if(sender.isChecked){
            sender.layer.borderWidth = 0
            sender.isChecked = false
        }else{
            sender.layer.borderWidth = 1
            sender.isChecked = true
        }
        
    }
    
    
    private func setupButton() {
        self.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)

        layer.borderColor = Colors.accentColor.cgColor
        layer.backgroundColor = Colors.mainBlue.cgColor
        self.titleLabel?.numberOfLines = 0
        self.titleEdgeInsets =  UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        self.titleLabel!.font = UIFont(name: "HelveticaNeue", size: 20)
        self.titleLabel?.tintColor = .white
        layer.borderWidth = 0
        layer.cornerRadius  = 12
        setTitleColor(.white, for: .normal)
    }
}
