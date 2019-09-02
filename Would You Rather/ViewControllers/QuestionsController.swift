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
    var options = [DisplayButton]()
    
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
        options = [questionsView.option1,questionsView.option2]
        setupView()
    }
    
    fileprivate func setupView(){
        view = questionsView
        questionsView.nextButton.onClickListener = getNextQuestion
        options.forEach {$0.onClickListener = handleClick}
        showQuestion()
    }
    
    func handleClick() {
        options.forEach {$0.isUserInteractionEnabled = false}
        playAudioSound()
        
        FirebaseProxy.vote(forQuestion: viewModel.currentQuestion,
                           option: options.firstIndex(where: {$0.isChecked}) ?? 0)
        
        guard let votes1 = viewModel.currentQuestion?.votes1 else {return}
        guard let votes2 = viewModel.currentQuestion?.votes2 else {return}
        let total = votes1 + votes2
        
        questionsView.firstPercentage.text = "\(((votes1/total) * 100).rounded().toInt()!)%"
        questionsView.secondPercentage.text = "\(((votes2/total) * 100).rounded().toInt()!)%"
    }
    
    func playAudioSound() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf:
                URL(fileURLWithPath: Bundle.main.path(forResource: "btn_click_soft", ofType: "mp3")!))
            audioPlayer.play()
        } catch {print("Couldnt play audio sound")}
    }
    
    func showQuestion() {
        self.questionsView.option1.setTitle(viewModel.currentQuestion?.question1, for: .normal)
        self.questionsView.option2.setTitle(viewModel.currentQuestion?.question2, for: .normal)
        options.forEach {$0.animateSlide(inView: questionsView)}
        print("question id: \(String(describing: viewModel.currentQuestion?.id))")

    }
    
    func getNextQuestion() {
        questionsView.firstPercentage.text = ""
        questionsView.secondPercentage.text = ""
        viewModel.getQuestion {
            self.showQuestion()
            self.options.forEach {
                $0.isUserInteractionEnabled = true
                $0.uncheck()
            }
        }
    }
}



    


