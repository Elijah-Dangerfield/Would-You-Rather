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
    
    var startView =  StartView()
    var options = [DisplayButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.isTranslucent = false
        
        options = [startView.option1,startView.option2,startView.option3]
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        options.forEach { btn in btn.uncheck()}
    }
    
    fileprivate func setupView(){
        
        startView.startButton.onClickListener = handleStartButtonClick
        view = startView
    }
    
    func handleStartButtonClick() {
        startView.startButton.isUserInteractionEnabled = false
        let chosenPacks = options.filter { $0.isChecked}.map {$0.currentTitle!.lowercased()}

        if(Reachability.isConnectedToNetwork()){
            if chosenPacks.isEmpty{
                let alert = UIAlertController(title: "No packs Selected", message: "Please chose a pack", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { _ in
                    self.startView.startButton.isUserInteractionEnabled = true
                    return
                }))
                self.present(alert, animated: true, completion: nil)
            }else{
                print("User has started game")
                let questionsVC = QuestionsController()
                questionsVC.chosenPacks = chosenPacks
                self.navigationController?.pushViewController(questionsVC, animated: false)
                self.startView.startButton.isUserInteractionEnabled = true
            }
        }else{
            let alert = UIAlertController(title: "No internect connection", message: "We're sorry, this game requires an internet connection", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action: UIAlertAction!) in
                self.startView.startButton.isUserInteractionEnabled = true
                return
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}

