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
        
        setUpNavBar()
        options = [startView.option1,startView.option2,startView.option3]
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        options.forEach { btn in btn.uncheck()}
    }
    
    fileprivate func setUpNavBar() {
        self.navigationController!.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    fileprivate func setupView() {
        startView.startButton.onClickListener = handleStartButtonClick
        view = startView
    }
    
    func handleStartButtonClick() {
        startView.startButton.isUserInteractionEnabled = false
        let chosenPacks = options.filter { $0.isChecked}.map {$0.currentTitle!.lowercased()}
        
        if(!Reachability.isConnectedToNetwork()) {
            showSimpleAlert(withTitle: "No Internet Connection",
                            message: "Please check your connection and try again")
            startView.startButton.isUserInteractionEnabled = true
            return
        }
        
        if(chosenPacks.isEmpty) {
            showSimpleAlert(withTitle: "No Selected Packs",
                            message: "Please chose a pack")
            startView.startButton.isUserInteractionEnabled = true
            return
        }
        startGame(with: chosenPacks)
    }
    
    func startGame(with chosenPacks: [String]) {
         GameViewModel(withPacks: chosenPacks) { gameViewModel in
            let questionsVC = QuestionsController(viewModel: gameViewModel)
            self.navigationController?.pushViewController(questionsVC, animated: false)
            self.startView.startButton.isUserInteractionEnabled = true
        }
       
    }
}

