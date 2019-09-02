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

    static func getQuestion(withId id: Int, then completion: @escaping (Question) -> Void){
        //get next question
        db.collection("Test").document("\(id)").getDocument { (doc, err) in
            if let doc = doc, doc.exists {
                let question = Question(id: id, dictionary: doc.data()!) //banged because if the document was invalid the guard wouldve caught it
                completion(question)
            }
        }
    }
    
    static func vote(forQuestion question: Question?, option: Int ) {
        guard let question = question else {return}
        
        db.collection("Test").document("\(question.id)")
            .updateData(["\(option + 1)": FieldValue.increment(1.0)])  // +1 for index 0
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
                if(completed == chosenPacks.count) {completion(pool.shuffled())}
            }
        }
    }
}
