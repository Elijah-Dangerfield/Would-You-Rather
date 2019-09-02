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
    
    var questionsView = QuestionsView()
    var audioPlayer = AVAudioPlayer()
    var viewModel: GameViewModel
    
     init(viewModel: GameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        setupView()
    }
    
    fileprivate func setupView(){
    
        view = questionsView
        showQuestion()
    }
    
    func showQuestion() {
        self.questionsView.option1.titleLabel?.text = viewModel.currentQuestion?.question1
        self.questionsView.option2.titleLabel?.text = viewModel.currentQuestion?.question2
    }
    
    

}



    


