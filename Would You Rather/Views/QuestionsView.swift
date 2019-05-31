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
    
    var orLabel: UILabel = {
        
        let label = UILabel()
        label.text = "OR"
        label.textColor = UIColor().HexToColor(hexString: "#FFFFFF", alpha: 1)
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var firstPercentage: UILabel = {
        
        let label = UILabel()
        label.textColor = UIColor().HexToColor(hexString: "#FFFFFF", alpha: 1)
        label.font = UIFont(name: "HelveticaNeue", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var secondPercentage: UILabel = {
        
        let label = UILabel()
        label.textColor = UIColor().HexToColor(hexString: "#FFFFFF", alpha: 1)
        label.font = UIFont(name: "HelveticaNeue", size: 20)
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
    
    var option1: DisplayButton = {
        
        let option = DisplayButton()
        option.titleLabel!.font = UIFont(name: "HelveticaNeue", size: 20)
        option.translatesAutoresizingMaskIntoConstraints = false
        return option
    }()
    
    var option2: DisplayButton = {
        
        let option = DisplayButton()
        option.titleLabel!.font = UIFont(name: "HelveticaNeue", size: 20)
        option.translatesAutoresizingMaskIntoConstraints = false
        return option
    }()
    
    var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.backgroundColor = Colors.mainBlue.cgColor
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
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
        containerView.addSubview(orLabel)
        containerView.addSubview(option1)
        containerView.addSubview(option2)
        containerView.addSubview(firstPercentage)
        containerView.addSubview(secondPercentage)
        self.addSubview(containerView)
        self.addSubview(nextButton)
        setConstraints()
        
    }
    
    fileprivate func setConstraints(){
        
        Constraints.constraintWithTopAndCenterXAnchor(field: titleLabel, width: 0, height: 30, topAnchor: topAnchor, topConstant: UIElementSizes.navigationBarHeight - 25, centerXAnchor: centerXAnchor, centerXConstant: 0)
        
        Constraints.constrainWithBottomAndTopLeadingAndTrailing(field: containerView, width: 0, height: 0, bottomAnchor: nextButton.topAnchor, bottomConstant: -25, topAnchor: titleLabel.bottomAnchor, topConstant: 25, leadingAnchor: leadingAnchor, leadingConstant: 25, trailingAnchor: trailingAnchor, trailingConstant: -25)
        
        Constraints.constraintWithCenterYAndCenterXAnchor(field: orLabel, width: 0, height: 0, centerYAnchor: containerView.centerYAnchor, centerYConstant: 0, centerXAnchor: containerView.centerXAnchor, centerXConstant: 0)
        
        Constraints.constrainWithBottomAndTopLeadingAndTrailing(field: option1, width: 0, height: 0, bottomAnchor: orLabel.topAnchor, bottomConstant: -25, topAnchor: containerView.topAnchor, topConstant: 0, leadingAnchor: containerView.leadingAnchor, leadingConstant: 0, trailingAnchor: containerView.trailingAnchor, trailingConstant: 0)
        
        Constraints.constrainWithBottomAndTopLeadingAndTrailing(field: option2, width: 0, height: 0, bottomAnchor: containerView.bottomAnchor, bottomConstant: 0, topAnchor: orLabel.bottomAnchor, topConstant: 25, leadingAnchor: containerView.leadingAnchor, leadingConstant: 0, trailingAnchor: containerView.trailingAnchor, trailingConstant: 0)
        
        Constraints.constraintWithBottomAndCenterXAnchor(field: nextButton, width: UIElementSizes.buttonWidth, height: 75, bottomAnchor: bottomAnchor, bottomConstatnt: -75, centerXAnchor: centerXAnchor, centerXConstant: 0)
        
        Constraints.constraintWithBottomAndLeading(field: firstPercentage, width: 0, height: 0, bottomAnchor: option1.bottomAnchor, bottomConstant: -5, leadingAnchor: option1.leadingAnchor, leadingConstant: 5)
        
        Constraints.constraintWithBottomAndLeading(field: secondPercentage, width: 0, height: 0, bottomAnchor: option2.bottomAnchor, bottomConstant: -5, leadingAnchor: option2.leadingAnchor, leadingConstant: 5)
    }
    
}
