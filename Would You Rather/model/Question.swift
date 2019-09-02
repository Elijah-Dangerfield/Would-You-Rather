//
//  Question.swift
//  Would You Rather
//
//  Created by eli dangerfield on 9/2/19.
//  Copyright © 2019 eli dangerfield. All rights reserved.
//

import Foundation

class Question {
    
    let votes1: Double
    let votes2: Double
    let question1: String
    let question2: String
    
    init(votes1: Double,votes2: Double,question1: String,question2: String) {
        self.votes1 = votes2
        self.votes2 = votes2
        self.question1 = question1
        self.question2 = question2
    }
}
