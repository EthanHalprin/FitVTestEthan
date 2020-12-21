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
        
//        do {
//            try viewModel.fetchExercises("http://fitv.exercises.com")
//        } catch {
//            fatalError("Could not load exercises")
//        }
    }

    @IBAction func A_TouchUpInside(_ sender: UIButton) {
        viewModel.userCode += "A"
        
        if viewModel.userCode == "AA" {
            NotificationCenter.default.post(name    : .correctCodeDidEnter,
                                            object  : self,
                                            userInfo: nil)
        }
    }
    
    @IBAction func B_TouchUpInside(_ sender: UIButton) {
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
