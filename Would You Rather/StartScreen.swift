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

    @IBOutlet weak var startButton: ActionButton!
    @IBOutlet weak var option1: DisplayButton!
    var selectedRanges = [Range<Int>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        
        option1.addTarget(self, action: #selector(addOptions(sender:)), for: .touchUpInside)

        
    }
    
    @objc
    func addOptions(sender: DisplayButton){
        
        if(!sender.isChecked){
            sender.layer.borderWidth = 1
            sender.isChecked = true
        }else{
            sender.layer.borderWidth = 0
            sender.isChecked = false
        }
    }
    
    //so what im thinking is that when a user clicks start I fecth from firebase the ranges corresponding to a given choice
    //an array is build with indecies corresponding to all of the choices and that array is used in practice
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if segue.identifier == "segueStartGame"  {
           
            let secondViewController = segue.destination as! ViewController
                
                // set a variable in the second view controller with the data to pass
            
                secondViewController.unseenQuestions = Array (0...50)
            }
        }
        
    }

