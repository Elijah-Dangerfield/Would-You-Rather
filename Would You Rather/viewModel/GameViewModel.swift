//
//  GameViewModel.swift
//  Would You Rather
//
//  Created by eli dangerfield on 9/2/19.
//  Copyright © 2019 eli dangerfield. All rights reserved.
//

import Foundation

//class such that it can be passed around by reference.
class GameViewModel {
    
    var chosenPacks = [String]()
    var currentQuestion: Question?
    var pool = [Int]()
    
    init(withPacks chosenPacks: [String]) {
        self.chosenPacks = chosenPacks
        FirebaseProxy.getPool(fromPacks: chosenPacks) {res in
            self.pool = res
            self.getQuestion(withId: self.pool.popLast()) {print("EMPTY POOL ON INIT OF VIEW MODEL")}
        }
    }
    
    func getQuestion(withId id : Int?, whenEmpty: (() -> Void) = {}) {
        guard let id = id else { whenEmpty()
            return
        }
        self.currentQuestion = FirebaseProxy.getQuestion(withId: id)
    }
}
