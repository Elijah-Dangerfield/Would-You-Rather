//
//  DisplayButton.swift
//  Would You Rather
//
//  Created by eli dangerfield on 4/30/19.
//  Copyright © 2019 eli dangerfield. All rights reserved.
//
import UIKit
typealias ACTION = (() -> ())?

class DisplayButton: UIButton {
    
    var isChecked: Bool = false
    var onClickListener: ACTION = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    @objc
    func toggle(sender: DisplayButton){
        
        if(isChecked){
            uncheck()
        }else{
            check()
        }
    }
    
    func check(){
        layer.borderWidth = 1
        isChecked = true
    }
    
    func uncheck(){
        layer.borderWidth = 0
        isChecked = false
    }
    
    @objc
    func handleAction() {
        onClickListener?()
    }
    
    private func setupButton() {
        addTarget(self, action: #selector(toggle(sender:)), for: .touchUpInside)
        addTarget(self, action: #selector(handleAction), for: .touchUpInside)
        layer.borderColor = Colors.accentColor.cgColor
        layer.backgroundColor = Colors.mainBlue.cgColor
        isExclusiveTouch = true
        titleLabel?.numberOfLines = 0
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.lineBreakMode = .byWordWrapping
        titleLabel?.minimumScaleFactor = 0.01
        titleEdgeInsets =  UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        titleLabel!.font = UIFont(name: "System", size: 44)
        titleLabel?.tintColor = .white
        layer.borderWidth = 0
        layer.cornerRadius  = 12
        setTitleColor(.white, for: .normal)
    }
}
