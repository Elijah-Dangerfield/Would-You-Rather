//
//  View+Constraints.swift
//  Would You Rather
//
//  Created by eli dangerfield on 9/1/19.
//  Copyright © 2019 eli dangerfield. All rights reserved.
//

import UIKit
extension UIView {
    
    func build() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func top(_ constraint: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> UIView {
        self.topAnchor.constraint(equalTo: constraint, constant: constant).isActive = true
        return self
    }
    
    func leading(_ constraint: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> UIView {
        self.leadingAnchor.constraint(equalTo: constraint, constant: constant).isActive = true
        return self
    }
    
    func centerX(_ constraint: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> UIView {
        self.centerXAnchor.constraint(equalTo: constraint, constant: constant).isActive = true
        return self
    }
    
    func centerY(_ constraint: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> UIView {
        self.centerYAnchor.constraint(equalTo: constraint, constant: constant).isActive = true
        return self
    }
    
    func trailing(_ constraint: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> UIView {
        self.trailingAnchor.constraint(equalTo: constraint, constant: constant).isActive = true
        return self
    }
    
    func bottom(_ constraint: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> UIView {
        self.bottomAnchor.constraint(equalTo: constraint, constant: constant).isActive = true
        return self
    }
    
    func height(_ constraint: NSLayoutDimension, constant: CGFloat = 0) -> UIView {
        self.heightAnchor.constraint(equalTo: constraint, constant: constant).isActive = true
        return self
    }
    
    func width(_ constraint: NSLayoutDimension, constant: CGFloat = 0) -> UIView {
        self.widthAnchor.constraint(equalTo: constraint, constant: constant).isActive = true
        return self
    }
    
    func height(_ constant: CGFloat = 0) -> UIView {
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    func width(_ constant: CGFloat = 0) -> UIView {
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    func addSubviews(_ views: [UIView]) {
        for view in views {
            self.addSubview(view)
        }
    }
}
