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

class startScreen: UIViewController {

    @IBOutlet weak var option1: DisplayButton!
    @IBOutlet weak var option2: DisplayButton!
    @IBOutlet weak var option3: DisplayButton!
    @IBOutlet weak var option4: DisplayButton!
    @IBOutlet weak var startButton: ActionButton!
    var chosenPacks = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        option1.addTarget(self, action: #selector(addOptions(sender:)), for: .touchUpInside)
        option2.addTarget(self, action: #selector(addOptions(sender:)), for: .touchUpInside)
        option3.addTarget(self, action: #selector(addOptions(sender:)), for: .touchUpInside)
        option4.addTarget(self, action: #selector(addOptions(sender:)), for: .touchUpInside)
        
    }
    
    @objc
    func addOptions(sender: DisplayButton){
        
        if(!sender.isChecked){
            if let selectedPack = sender.currentTitle?.lowercased(){
                chosenPacks.append(selectedPack)
                print("New Chosen Packs array \(chosenPacks)")
                sender.layer.borderWidth = 1
                sender.isChecked = true
            }
        }else{
            if let selectedPack = sender.currentTitle?.lowercased(){
                if let index = chosenPacks.firstIndex(of: selectedPack) {
                    chosenPacks.remove(at: index)
                    sender.layer.borderWidth = 0
                    sender.isChecked = false
                    print("New Chosen Packs array \(chosenPacks)")

                    }
                }
            }
    }
    
    
    //so what im thinking is that when a user clicks start I fecth from firebase the ranges corresponding to a given choice
    //an array is build with indecies corresponding to all of the choices and that array is used in practice
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if chosenPacks.isEmpty{
            let alert = UIAlertController(title: "No packs Selected", message: "Please chose a pack", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action: UIAlertAction!) in
                return
            }))
            self.present(alert, animated: true, completion: nil)
        }
        //based on which ui buttons are checked create the unseenQuestions array.
        //you should be able to pull in stop and start index, create arrays out of those and combine them and assign them over
        
        if segue.identifier == "segueStartGame"  {
           
            let secondViewController = segue.destination as! ViewController
                
                // set a variable in the second view controller with the data to pass
                secondViewController.chosenPacks = self.chosenPacks
            }
        }
    
    

        
    }

