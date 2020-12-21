//
//  SetUpViewController.swift
//  FitV
//
//  Created by Ethan on 20/12/2020.
//
import UIKit


class SetUpViewController: UIViewController {
    
    var viewModel = ViewModel()
    @IBOutlet weak var inputLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        do {
            try viewModel.fetch("https://ios-interviews.dev.fitvdev.com/getWorkoutDetails")
        } catch {
            fatalError("Could not load exercises")
        }
    }

    @IBAction func A_TouchUpInside(_ sender: UIButton) {
        didUserTouchUpInside("a")
    }
    
    @IBAction func B_TouchUpInside(_ sender: UIButton) {
        didUserTouchUpInside("b")
    }
    
    @IBAction func C_TouchUpInside(_ sender: UIButton) {
        didUserTouchUpInside("c")
    }
    
    @IBAction func D_TouchUpInside(_ sender: UIButton) {
        didUserTouchUpInside("d")
    }
        
    @IBAction func E_TouchUpInside(_ sender: UIButton) {
        didUserTouchUpInside("e")
    }
    
    @IBAction func F_TouchUpInside(_ sender: UIButton) {
        didUserTouchUpInside("f")
    }
}

extension SetUpViewController {
    
    func notify() {
        NotificationCenter.default.post(name    : .correctCodeDidEnter,
                                        object  : self,
                                        userInfo: nil)
    }
    
    fileprivate func didUserTouchUpInside(_ input: String) {
        inputLabel.text! += "*"
        let result = viewModel.scanCode(input)
        switch result {
        case .codesUnavailable:
            fatalError("Could not parse or fetch workout codes")
        case .match:
            self.notify()
        case .mismatch:
            break
        case .overflow:
            break
        case .forbidden:
            fatalError("Verifying code is out of this state's scope")
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
