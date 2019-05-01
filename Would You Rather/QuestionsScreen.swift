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
    
    
    @IBOutlet weak var secondPercentage: UILabel!
    @IBOutlet weak var firstPercentage: UILabel!
    @IBOutlet weak var firstOption: UIButton!
    @IBOutlet weak var secondOption: UIButton!
    var total : Int?
    var seenQuestions = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        generateDocs()
        getInfo()
        firstOption.addTarget(self, action: #selector(vote(sender:)), for: .touchUpInside)
        secondOption.addTarget(self, action: #selector(vote(sender:)), for: .touchUpInside)

    }
    
    @IBAction func next(_ sender: UIButton) {
        
        firstOption.layer.borderWidth = 0
        secondOption.layer.borderWidth = 0
        firstPercentage.text = ""
        secondPercentage.text = ""

        if(seenQuestions.count >= total!){
        
            firstOption.isUserInteractionEnabled = false
            secondOption.isUserInteractionEnabled = false
            
            let alert = UIAlertController(title: "Out of questions", message: "More questions coming soon!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (action: UIAlertAction!) in
                self.seenQuestions = []
                let nextQuestion = self.randomUnseen()
                self.loadQuestion(String(nextQuestion))
            }))
            self.present(alert, animated: true, completion: nil)
            
        }else{
            
        let nextQuestion = self.randomUnseen()
        self.loadQuestion(String(nextQuestion))
        }
    }
    
    @objc func vote(sender: UIButton){
        let db = Firestore.firestore()
        let currentQuestion = String(seenQuestions.last!)
        let answerRef = db.collection("Test").document(currentQuestion)
        
        // Atomically incrememnt the population of the city by 50.
        // Note that increment() with no arguments increments by 1.
        if (sender == firstOption){
            firstOption.layer.borderWidth = 1
            firstOption.layer.borderColor = #colorLiteral(red: 0.4411836407, green: 1, blue: 0.8514406318, alpha: 1)
            answerRef.updateData([
            "1": FieldValue.increment(1.0)
            ])
        }else{
        secondOption.layer.borderWidth = 1
        secondOption.layer.borderColor = #colorLiteral(red: 0.4411836407, green: 1, blue: 0.8514406318, alpha: 1)
        answerRef.updateData([
            "2": FieldValue.increment(1.0)
            ])
        }
        answerRef.getDocument { (document, error) in
            if let document = document, document.exists {
                
                if let pFirst = document.get("1") as! Double? {
                    if let pSecond = document.get("2") as! Double? {
                        let proportionFirst = Int((pFirst/(pFirst+pSecond))*100)
                        print("First proportiong \(proportionFirst)")
                        self.firstPercentage.text = "\(proportionFirst)%"
                        self.secondPercentage.text = "\(100 - proportionFirst)%"
                    }
                }else{
                    print("Couldnt do the percentage thing \n\n")
                }
            } else {
                print("Document does not exist")
            }
        }
        firstOption.isUserInteractionEnabled = false
        secondOption.isUserInteractionEnabled = false

    }
    
    fileprivate func loadQuestion(_ index: String) {
        // Do any additional setup after loading the view.

        let db = Firestore.firestore()
        let docRef = db.collection("Test").document(index)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                
                if let questions = document.get("questions") as! [String]? {
                    self.firstOption.setTitle(questions[0], for: .normal)
                    self.secondOption.setTitle(questions[1], for: .normal)
                    self.firstOption.isUserInteractionEnabled = true
                    self.secondOption.isUserInteractionEnabled = true
                    self.seenQuestions.append(Int(index)!)
                    print("new seen questions array: \(self.seenQuestions)")
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
                let firstQuestion = self.randomUnseen()
                self.loadQuestion(String(firstQuestion))
            } else {
            }
        }
        
    }

    func generateDocs(){
        let db = Firestore.firestore()

        for i in 51...100{
            var index = String(i)
            db.collection("Test").document(index).delete() { err in
                if let err = err {
                    print("Error deleting document: \(err)")
                } else {
                    
                }
            }
        }
    }
    
    func randomUnseen()-> Int{
        //I want to create a range to pull a random into from 0-total making sure not to include numbers that are in the seen array
        let totalRange = (0...self.total!)
        let unseenRange = totalRange.filter {n in
            //returns number if it is not in the seenquestions array
            !self.seenQuestions.contains(n)
            }
       let result = unseenRange.randomElement()
        print("The random unseen indecy is: \(String(describing: result))")
        return result!
    }
    
   

}

