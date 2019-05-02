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
import AVFoundation
class ViewController: UIViewController {
    
    
    @IBOutlet weak var secondPercentage: UILabel!
    @IBOutlet weak var firstPercentage: UILabel!
    @IBOutlet weak var firstOption: UIButton!
    @IBOutlet weak var secondOption: UIButton!
    var audioPlayer = AVAudioPlayer()
    var total : Int?
    var seenQuestions = [Int]()
    var unseenQuestions = [Int]()
    var chosenPacks = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        //okay so now we need to use the chosen packs to build the unseen questions array
        downloadPacks() {
           //stuff to do once complete now that the unseen array is filled
            self.startGame()
            print("unseen questions:", self.unseenQuestions)
        }
        
        firstOption.addTarget(self, action: #selector(vote(sender:)), for: .touchUpInside)
        secondOption.addTarget(self, action: #selector(vote(sender:)), for: .touchUpInside)

    }
    
    func animateButtons() {
        firstOption.center.x = view.center.x // Place it in the center x of the view.
        firstOption.center.x += (view.bounds.width)/2// Place it on the right of the view with the width = the bounds'width of the view.
        animateSlideIn(sender: firstOption)
        
        secondOption.center.x = view.center.x // Place it in the center x of the view.
        secondOption.center.x += (view.bounds.width)/2 // Place it on the right of the view with the width = the bounds'width of the view.
        animateSlideIn(sender: secondOption)
    }
    
    func animateSlideIn(sender: UIButton){
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            sender.center.x -= self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func downloadPacks(completion: @escaping () -> Void) {
        let db = Firestore.firestore()
        let collection = db.collection("Packs")
        collection.getDocuments { snapshot, error in
            print(error ?? "No error.")
            guard let snapshot = snapshot else {
                completion()
                return
            }
            for doc in snapshot.documents {
                if self.chosenPacks.contains(doc.documentID.lowercased()){
                    var range = doc.get("range") as! [Int]
                    let list = Array(range[0]...range[1])
                    self.unseenQuestions.append(contentsOf:(list))
                }
            }
            completion()
        }
    }
    
   
    
    @IBAction func next(_ sender: UIButton) {
        
        firstOption.layer.borderWidth = 0
        secondOption.layer.borderWidth = 0
        firstPercentage.text = ""
        secondPercentage.text = ""

        if(seenQuestions.count >= total!){
        
            firstOption.isUserInteractionEnabled = false
            secondOption.isUserInteractionEnabled = false
            
            let alert = UIAlertController(title: "Out of questions in the chosen packs", message: "More questions coming soon!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (action: UIAlertAction!) in
                self.seenQuestions = []
                self.downloadPacks {
                    self.startGame()                }
                
            }))
            self.present(alert, animated: true, completion: nil)
            
        }else{
            nextQuestion()
        }
    }
    
    @objc func vote(sender: UIButton){
        let sound = URL(fileURLWithPath: Bundle.main.path(forResource: "btn_click_soft", ofType: "mp3")!)
        let db = Firestore.firestore()
        let currentQuestion = String(seenQuestions.last!)
        let answerRef = db.collection("Test").document(currentQuestion)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: sound)
            audioPlayer.play()
            print("Did play audio sound")

        } catch {
            // couldn't load file :(
            print("Couldnt play audio sound")
        }
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
                    self.animateButtons()
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
            //it was passed in through segue
        self.nextQuestion()
        self.total = unseenQuestions.count
        }
        
    
    
    
}



    


