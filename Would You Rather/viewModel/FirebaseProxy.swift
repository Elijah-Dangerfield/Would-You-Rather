//
//  FirebaseProxy.swift
//  Would You Rather
//
//  Created by eli dangerfield on 9/2/19.
//  Copyright © 2019 eli dangerfield. All rights reserved.
//

import Foundation
import Firebase

struct FirebaseProxy {
    private static let db = Firestore.firestore()

    static func getQuestion(withId id: Int) -> Question{
        //get next question
        return Question(votes1: 0, votes2: 0, question1: "", question2: "")
    }
    
    static func getPool(fromPacks chosenPacks: [String],completion: @escaping ([Int]) -> Void) {
        //get the ranges for each pack, build the pool and return it
        var completed = 0
        var pool = [Int]()
        for pack in chosenPacks {
            db.collection("Packs").document(pack.lowercased()).getDocument { (doc, err) in
                guard let doc = doc else {return}
                var range = doc.get("range") as! [Int]
                let list = Array(range[0]...range[1])
                pool.append(contentsOf: list)
                completed += 1
                if(completed == chosenPacks.count) {completion(pool)}
            }
        }
    }
}
