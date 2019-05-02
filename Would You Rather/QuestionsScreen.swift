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
    var unseenQuestions = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")

        //generateDocs()
        startGame()
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
                self.unseenQuestions = []
                self.startGame()
            }))
            self.present(alert, animated: true, completion: nil)
            
        }else{
            nextQuestion()
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
            answerRef.updateData([
            "1": FieldValue.increment(1.0)
            ])
        }else{
        secondOption.layer.borderWidth = 1
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
    
    func loadQuestion(_ index: String) {
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
                }
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
       
    }
    
    func nextQuestion(){
        let nextQuestion =  self.unseenQuestions.remove(at: Int.random(in: 0...self.unseenQuestions.count-1))
        self.seenQuestions.append(nextQuestion)
        self.loadQuestion(String(nextQuestion))
        print("new seen questions array: \(self.seenQuestions)")
    }
    
    func startGame() {
        self.seenQuestions = []
        let db = Firestore.firestore()
        let docRef = db.collection("Test").document("info")
        
        //maybe instead of reseting the user should just be pushed back to the main screen
        if unseenQuestions.isEmpty{
        //restarting game
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.total = document.get("total") as! Int? ?? 0
                //here I could just make the array equal to the arrays passed in
                if let total = self.total{
                self.unseenQuestions = Array (0...total)
                self.nextQuestion()
                }
            }
        }
        }else{
            //it was passed in through segue
            self.nextQuestion()
            self.total = unseenQuestions.count
        }
        
    }
    
    
}
    


