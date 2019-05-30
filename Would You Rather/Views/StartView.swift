//
//  StartView.swift
//  Would You Rather
//
//  Created by eli dangerfield on 5/30/19.
//  Copyright © 2019 eli dangerfield. All rights reserved.
//
import UIKit

class StartView: UIView{
    
    var titleLabel: UILabel = {
       
        let label = UILabel()
        label.text = "Would You Rather"
        label.textColor = UIColor().HexToColor(hexString: "#FFFFFF", alpha: 1)
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var optionsHeaderLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = UIColor().HexToColor(hexString: "#FFFFFF", alpha: 1)
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 22)
        let attributedString = NSMutableAttributedString(string: "Pick your poison:")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        label.attributedText = attributedString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var option1: DisplayButton = {
        
        let option = DisplayButton()
        option.setTitle("Easy Decisions", for: .normal)
        option.titleLabel!.font = UIFont(name: "HelveticaNeue", size: 20)
        option.translatesAutoresizingMaskIntoConstraints = false
        return option
    }()
    
    var option2: DisplayButton = {
        
        let option = DisplayButton()
        option.setTitle("Question Your Morals", for: .normal)
        option.titleLabel!.font = UIFont(name: "HelveticaNeue", size: 20)
        option.translatesAutoresizingMaskIntoConstraints = false
        return option
    }()
    
    var option3: DisplayButton = {
        
        let option = DisplayButton()
        option.setTitle("R-Rated", for: .normal)
        option.translatesAutoresizingMaskIntoConstraints = false
        return option
    }()

    var startButton: ActionButton = {
        
        let button = ActionButton()
        button.setTitle("Start", for: .normal)
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
        self.addSubview(optionsHeaderLabel)
        self.addSubview(option1)
        self.addSubview(option2)
        self.addSubview(option3)
        self.addSubview(startButton)
        setConstraints()
        
    }
    
    fileprivate func setConstraints(){
        
        Constraints.constraintWithTopAndCenterXAnchor(field: titleLabel, width: 0, height: 30, topAnchor: topAnchor, topConstant: UIElementSizes.navigationBarHeight, centerXAnchor: centerXAnchor, centerXConstant: 0)
        
        Constraints.constraintWithTopAndLeadingAnchor(field: optionsHeaderLabel, width: 0, height: 30, topAnchor: titleLabel.bottomAnchor, topConstant: 50, leadingAnchor: titleLabel.leadingAnchor, leadingConstant: 0)
        
        Constraints.constraintWithTopAndCenterXAnchor(field: option1, width: UIElementSizes.buttonWidth, height: 100, topAnchor: optionsHeaderLabel.bottomAnchor, topConstant: 25, centerXAnchor: centerXAnchor, centerXConstant: 0)
        
        Constraints.constraintWithTopAndCenterXAnchor(field: option2, width: UIElementSizes.buttonWidth, height: 100, topAnchor: option1.bottomAnchor, topConstant: 25, centerXAnchor: centerXAnchor, centerXConstant: 0)
        
        Constraints.constraintWithTopAndCenterXAnchor(field: option3, width: UIElementSizes.buttonWidth, height: 100, topAnchor: option2.bottomAnchor, topConstant: 25, centerXAnchor: centerXAnchor, centerXConstant: 0)
        
        Constraints.constraintWithBottomAndCenterXAnchor(field: startButton, width: UIElementSizes.buttonWidth, height: 75, bottomAnchor: bottomAnchor, bottomConstatnt: -75, centerXAnchor: centerXAnchor, centerXConstant: 0)
    }
    
}
