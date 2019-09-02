//
//  Question.swift
//  Would You Rather
//
//  Created by eli dangerfield on 9/2/19.
//  Copyright © 2019 eli dangerfield. All rights reserved.
//

import Foundation

class Question {
    
    let id: Int
    let votes1: Double
    let votes2: Double
    let question1: String
    let question2: String
    
    init(id: Int, dictionary: [String: Any]) {
        self.id = id
        self.votes1 = dictionary["1"] as? Double ?? 0.0
        self.votes2 = dictionary["2"] as? Double ?? 0.0
        self.question1 = (dictionary["questions"] as? [String] ?? [String]())[0]
        self.question2 = (dictionary["questions"] as? [String] ?? [String]())[1]
    }
}
