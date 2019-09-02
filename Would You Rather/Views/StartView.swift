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
        return label
    }()
    
    var optionsHeaderLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = UIColor().HexToColor(hexString: "#FFFFFF", alpha: 1)
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 22)
        let attributedString = NSMutableAttributedString(string: "Pick your poison:")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        label.attributedText = attributedString
        return label
    }()
    
    var option1: DisplayButton = {
        
        let option = DisplayButton()
        option.setTitle("The Warm Up", for: .normal)
        option.titleLabel!.font = UIFont(name: "HelveticaNeue", size: 20)
        return option
    }()
    
    var option2: DisplayButton = {
        
        let option = DisplayButton()
        option.setTitle("Question Your Morals", for: .normal)
        option.titleLabel!.font = UIFont(name: "HelveticaNeue", size: 20)
        return option
    }()
    
    var option3: DisplayButton = {
        
        let option = DisplayButton()
        option.titleLabel!.font = UIFont(name: "HelveticaNeue", size: 20)
        option.setTitle("R-Rated", for: .normal)
        return option
    }()

    var startButton: ActionButton = {
        
        let button = ActionButton()
        button.setTitle("Start", for: .normal)
        button.titleLabel!.font = UIFont(name: "HelveticaNeue", size: 20)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [option1, option2, option3])
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        self.addSubviews([titleLabel,optionsHeaderLabel,stackView,startButton])
        setConstraints()
    }
    
    fileprivate func setConstraints(){
        
        titleLabel
            .top(safeAreaLayoutGuide.topAnchor)
            .centerX(centerXAnchor)
            .build()
        
        optionsHeaderLabel
            .top(titleLabel.bottomAnchor,constant: 50)
            .leading(titleLabel.leadingAnchor)
            .build()
        
        stackView
            .top(optionsHeaderLabel.bottomAnchor,constant: 25)
            .bottom(startButton.topAnchor,constant: -25)
            .leading(leadingAnchor,constant: 25)
            .trailing(trailingAnchor,constant: -25)
            .build()

        
        startButton
            .width(UIElementSizes.buttonWidth)
            .height(UIElementSizes.buttonHeight)
            .bottom(bottomAnchor,constant: -75)
            .centerX(centerXAnchor)
            .build()
        
    }
    
}
