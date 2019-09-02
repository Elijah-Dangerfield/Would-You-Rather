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
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var secondPercentage: UILabel = {
        
        let label = UILabel()
        label.textColor = UIColor().HexToColor(hexString: "#FFFFFF", alpha: 1)
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    var nextButton: ActionButton = {
        
        let button = ActionButton()
        button.setTitle("Next", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var option1: DisplayButton = {
        
        let option = DisplayButton()
        option.translatesAutoresizingMaskIntoConstraints = false
        return option
    }()
    
    var option2: DisplayButton = {
        
        let option = DisplayButton()
        option.translatesAutoresizingMaskIntoConstraints = false
        return option
    }()
    
    var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.backgroundColor = Colors.mainBlue.cgColor
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        view.build()
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
        
        self.addSubviews([titleLabel,containerView,nextButton])
        containerView.addSubviews([orLabel,option1,option2,firstPercentage,secondPercentage])
        setConstraints()
        
    }
    
    fileprivate func setConstraints(){
        
        titleLabel
        .top(safeAreaLayoutGuide.topAnchor)
        .centerX(centerXAnchor)
        .build()
        
        
        containerView
            .top(titleLabel.bottomAnchor,constant: 25)
            .leading(leadingAnchor,constant: 25)
            .trailing(trailingAnchor,constant: -25)
            .bottom(nextButton.topAnchor,constant: -25)
            .build()
        
        
        orLabel
            .centerX(containerView.centerXAnchor)
            .centerY(containerView.centerYAnchor)
            .build()
        
        option1
            .bottom(orLabel.topAnchor,constant: -25)
            .top(containerView.topAnchor)
            .leading(containerView.leadingAnchor)
            .trailing(containerView.trailingAnchor)
            .build()
        
        option2
            .top(orLabel.bottomAnchor,constant: 25)
            .bottom(containerView.bottomAnchor)
            .leading(containerView.leadingAnchor)
            .trailing(containerView.trailingAnchor)
            .build()
        
        
        nextButton
            .height(UIElementSizes.buttonHeight)
            .width(UIElementSizes.buttonWidth)
            .bottom(bottomAnchor, constant: -75)
            .centerX(centerXAnchor)
            .build()
        
        firstPercentage
            .top(option1.bottomAnchor,constant: 5)
            .trailing(containerView.trailingAnchor,constant: -5)
            .build()
       
        secondPercentage
            .bottom(option2.topAnchor,constant: -5)
            .leading(containerView.leadingAnchor, constant: 5)
    
    }
    
}
