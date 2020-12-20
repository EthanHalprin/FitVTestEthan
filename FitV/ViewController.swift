//
//  ViewController.swift
//  FitV
//
//  Created by Ethan on 20/12/2020.
//

import UIKit

class ViewController: UIViewController {

    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didPressStop),
                                               name: .userdidPressStop, object: nil)
        runExercises()
    }
    
    @objc func didPressStop(notification: Notification) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func stopTouchUpInside(_ sender: UIButton) {
        
    }
    
}

extension ViewController {
    
    func runExercises() {
        
        for exercise in viewModel.exersices {
            //
            // run exercise on screen with timer
            //
        }
        // if reached here - state change to finish
        
    }
}

