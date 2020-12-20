//
//  SetUpViewController.swift
//  FitV
//
//  Created by Ethan on 20/12/2020.
//

import UIKit

class SetUpViewController: UIViewController {
    
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try viewModel.fetchExercises("http://fitv.exercises.com")
        } catch {
            fatalError("Could not load exercises")
        }
    }

    @IBAction func A_TouchUpInside(_ sender: UIButton) {
        
        // if code exist this should fire event for state chang in viewmodel observer
        // and also will launch a notification for entering exercise (which we will listen to)
        viewModel.userCode += "A"
        
    }
    
    
    @IBAction func B_TouchUpInside(_ sender: UIButton) {
        
    }
    
}

