//
//  StartScreen.swift
//  Would You Rather
//
//  Created by eli dangerfield on 5/1/19.
//  Copyright © 2019 eli dangerfield. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
import Firebase

class StartController: UIViewController {
    
    lazy var startView: StartView = {return StartView()}()
    
    var chosenPacks = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.tintColor = .white
        UIElementSizes.navigationBarHeight = navigationController!.navigationBar.bounds.maxY
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.isTranslucent = false
        
        setupView()
    }
    
    fileprivate func setupView(){
        
        startView.option1.addTarget(self, action: #selector(addOptions(sender:)), for: .touchUpInside)
        startView.option2.addTarget(self, action: #selector(addOptions(sender:)), for: .touchUpInside)
        startView.option3.addTarget(self, action: #selector(addOptions(sender:)), for: .touchUpInside)
        startView.startButton.addTarget(self, action: #selector(handleStartButtonClick(sender:)), for: .touchUpInside)
        view = startView
        
    }
    
    @objc
    func handleStartButtonClick(sender: ActionButton){
        if chosenPacks.isEmpty{
            let alert = UIAlertController(title: "No packs Selected", message: "Please chose a pack", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action: UIAlertAction!) in
                return
            }))
            self.present(alert, animated: true, completion: nil)
        }else{
            print("User has started game")
            let questionsVC = QuestionsController()
            questionsVC.chosenPacks = self.chosenPacks
            self.navigationController?.pushViewController(questionsVC, animated: false)
        }
    }
    
    @objc
    func addOptions(sender: DisplayButton){
        
        if(sender.isChecked){
            if let selectedPack = sender.currentTitle?.lowercased(){
                chosenPacks.append(selectedPack)
                print("New Chosen Packs array \(chosenPacks)")
            }
        }else{
            if let selectedPack = sender.currentTitle?.lowercased(){
                if let index = chosenPacks.firstIndex(of: selectedPack) {
                    chosenPacks.remove(at: index)
                    print("New Chosen Packs array \(chosenPacks)")
                    
                }
            }
        }
    }
    
 
    func generateDocs(){
        
        let db = Firestore.firestore()
        let collection = db.collection("Test")
        
        for i in 0...400{
            collection.document(String(i)).updateData([
                "1": 0,
                "2": 0
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }        }
    }
}

