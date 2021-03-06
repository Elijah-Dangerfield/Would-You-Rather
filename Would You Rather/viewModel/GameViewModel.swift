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
    
    init(withPacks chosenPacks: [String], completion: @escaping (GameViewModel) -> Void) {
        self.chosenPacks = chosenPacks
        FirebaseProxy.getPool(fromPacks: chosenPacks) {res in
            self.pool = res
            self.getQuestion() {
                completion(self)
            }
        }
    }
    
    func getQuestion(whenEmpty: (() -> Void) = {}, completion: @escaping ()-> Void) {
        guard let id = self.pool.popLast() else { whenEmpty()
            return
        }
        FirebaseProxy.getQuestion(withId: id) {q in
            self.currentQuestion = q
            completion()
        }
    }
}
