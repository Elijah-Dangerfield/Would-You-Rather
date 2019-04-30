//
//  ViewController.swift
//  Would You Rather
//
//  Created by eli dangerfield on 4/29/19.
//  Copyright © 2019 eli dangerfield. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase
class ViewController: UIViewController {
    
    
    @IBOutlet weak var firstOption: UILabel!
    @IBOutlet weak var secondOption: UILabel!
    var total : Int?
    var seenQuestions = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                loadQuestion(String(0))
        //generateDocs()
        getInfo()
    }
    
    fileprivate func loadQuestion(_ index: String) {        // Do any additional setup after loading the view.
        let db = Firestore.firestore()
        let docRef = db.collection("Test").document(index)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                
                if let questions = document.get("question") as! [String]? {
                    self.firstOption.text = questions[0]
                    self.secondOption.text = questions[1]
                }
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
       
    }
    
    func getInfo() {
        let db = Firestore.firestore()
        let docRef = db.collection("Test").document("info")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.total = document.get("total") as! Int? ?? 0
                print("total in function is: \(self.total)")
                
                
                
            } else {
            }
        }
        
    }

    func generateDocs(){
        let db = Firestore.firestore()

        for i in 0...100{
            var index = String(i)
            db.collection("Test").document(index).setData([
                "answers": [0,0],
                "questions": ["this 1","this 2"]
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            
        }
        
    }

}


extension Int {
    func randomUnseen(_ total:Int, _ seenQuestions: [Int])-> Int{
        let result = Int.random(in: (0..<total).filter() {
            !seenQuestions.contains($0)
            }.indices)
        
        return result
    }
}
