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
class QuestionsController: UIViewController {
    
    lazy var questionsView: QuestionsView = {return QuestionsView()}()

    var audioPlayer = AVAudioPlayer()
    var total : Int?
    var seenQuestions = [Int]()
    var unseenQuestions = [Int]()
    var chosenPacks = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
      //  okay so now we need to use the chosen packs to build the unseen questions array
        downloadPacks() {
           //stuff to do once complete now that the unseen array is filled
            self.startGame()
            print("unseen questions:", self.unseenQuestions)
        }
        setupView()
       

    }
    
    fileprivate func setupView(){
    
        questionsView.option1.addTarget(self, action: #selector(vote(sender:)), for: .touchUpInside)
        questionsView.option2.addTarget(self, action: #selector(vote(sender:)), for: .touchUpInside)
        questionsView.nextButton.addTarget(self, action: #selector(next(_:)), for: .touchUpInside)
        view = questionsView
        
    }

    func animateButtons() {
        questionsView.option1.center.x += (self.questionsView.bounds.width)// Place it on the right of the view with the width = the bounds'width of the view.
        questionsView.option2.center.x += (self.questionsView.bounds.width)// Place it on the right of the view with the width = the bounds'width of the view.

        
        animateSlideIn(sender: self.questionsView.option1)
        animateSlideIn(sender: self.questionsView.option2)

    }

    func animateSlideIn(sender: UIButton){
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            sender.center.x -= (self.questionsView.bounds.width)
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


    @objc
    func next(_ sender: UIButton) {

        questionsView.option1.layer.borderWidth = 0
        questionsView.option2.layer.borderWidth = 0
        self.questionsView.firstPercentage.text = ""
        self.questionsView.secondPercentage.text = ""

        if(seenQuestions.count >= total!){

            questionsView.option1.isUserInteractionEnabled = false
            questionsView.option2.isUserInteractionEnabled = false

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
        //set the next button to not be clickable until after the percentages show
        self.questionsView.nextButton.isUserInteractionEnabled = false
        
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
        if (sender == questionsView.option1){
            questionsView.option1.layer.borderWidth = 1
            answerRef.updateData([
            "1": FieldValue.increment(1.0)
            ])
        }else{
        questionsView.option2.layer.borderWidth = 1
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
                        self.questionsView.firstPercentage.text = "\(proportionFirst)%"
                        self.questionsView.secondPercentage.text = "\(100 - proportionFirst)%"
                        self.questionsView.nextButton.isUserInteractionEnabled = true
                    }
                }else{
                    print("Couldnt do the percentage thing \n\n")
                }
            } else {
                print("Document does not exist")
            }
        }
        questionsView.option1.isUserInteractionEnabled = false
        questionsView.option2.isUserInteractionEnabled = false

    }

    func loadQuestion(_ index: String) {
        // Do any additional setup after loading the view.

        let db = Firestore.firestore()
        let docRef = db.collection("Test").document(index)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {

                if let questions = document.get("questions") as! [String]? {
                    self.animateButtons()
                    self.questionsView.option1.setTitle(questions[0].lowercased(), for: .normal)
                    self.questionsView.option2.setTitle(questions[1].lowercased(), for: .normal)
                    self.questionsView.option1.isUserInteractionEnabled = true
                    self.questionsView.option2.isUserInteractionEnabled = true
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



    


