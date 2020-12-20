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
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didUserSuppliedCorrectCode),
                                               name: .correctCodeDidEneter, object: nil)
    }
    
    @objc func didUserSuppliedCorrectCode(notification: Notification) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let home = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        home.viewModel = self.viewModel
        navigationController?.pushViewController(home, animated: true)
    }


    @IBAction func A_TouchUpInside(_ sender: UIButton) {
        
        // if code exist this should fire event for state chang in viewmodel observer
        // and also will launch a notification for entering exercise (which we will listen to)
        viewModel.userCode += "A"
    }
    
    
    @IBAction func B_TouchUpInside(_ sender: UIButton) {
    }
    
}

