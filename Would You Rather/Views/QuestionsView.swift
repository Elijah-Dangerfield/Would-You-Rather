//
//  QuestionsView.swift
//  Would You Rather
//
//  Created by eli dangerfield on 5/30/19.
//  Copyright © 2019 eli dangerfield. All rights reserved.
//

import Foundation
import UIKit

class QuestionsView: UIView{
    
    var titleLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Would You Rather"
        label.textColor = UIColor().HexToColor(hexString: "#FFFFFF", alpha: 1)
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    var nextButton: ActionButton = {
        
        let button = ActionButton()
        button.setTitle("Next", for: .normal)
        button.titleLabel!.font = UIFont(name: "HelveticaNeue", size: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    fileprivate func setupView() {
        
        backgroundColor = Colors.mainBlue
        
        self.addSubview(titleLabel)
        self.addSubview(nextButton)
        setConstraints()
        
    }
    
    fileprivate func setConstraints(){
        
        Constraints.constraintWithTopAndCenterXAnchor(field: titleLabel, width: 0, height: 30, topAnchor: topAnchor, topConstant: UIElementSizes.navigationBarHeight, centerXAnchor: centerXAnchor, centerXConstant: 0)
        
        Constraints.constraintWithBottomAndCenterXAnchor(field: nextButton, width: UIElementSizes.buttonWidth, height: 75, bottomAnchor: bottomAnchor, bottomConstatnt: -75, centerXAnchor: centerXAnchor, centerXConstant: 0)
    }
    
}
