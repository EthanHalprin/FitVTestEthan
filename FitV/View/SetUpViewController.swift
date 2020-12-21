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
            try viewModel.fetchExercises("https://ios-interviews.dev.fitvdev.com/getWorkoutDetails")
        } catch {
            fatalError("Could not load exercises")
        }
    }

    @IBAction func A_TouchUpInside(_ sender: UIButton) {
        if let notificationName = viewModel.scanCode("A") {
            NotificationCenter.default.post(name    : notificationName,
                                            object  : self,
                                            userInfo: nil)
        }
    }
    
    @IBAction func B_TouchUpInside(_ sender: UIButton) {
        if let notificationName = viewModel.scanCode("B") {
            NotificationCenter.default.post(name    : notificationName,
                                            object  : self,
                                            userInfo: nil)
        }
    }
}

extension SetUpViewController: StateRespondibleViewController {
    
    func next() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let exerciseVC = storyBoard.instantiateViewController(withIdentifier: "ExerciseViewController") as! ExerciseViewController
        exerciseVC.viewModel = self.viewModel
        self.navigationController?.pushViewController(exerciseVC, animated: true)
    }
    
    func prev() { }
}
