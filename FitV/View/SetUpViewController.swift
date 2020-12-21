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
    @IBOutlet weak var feedbackLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        do {
            try viewModel.fetch("https://ios-interviews.dev.fitvdev.com/getWorkoutDetails")
        } catch {
            fatalError("Could not load exercises")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.inputLabel.text?.removeAll()
        self.viewModel.flushInputCode()
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
    
    fileprivate func notifyMatch() {
        NotificationCenter.default.post(name    : .correctCodeDidEnter,
                                        object  : self,
                                        userInfo: nil)
    }
    
    fileprivate func didUserTouchUpInside(_ input: String) {
        inputLabel.text! += "*"
        let result = viewModel.scanCode(input)
        switch result {
        case .codesUnavailable:
            print("Could not parse or fetch workout codes")
        case .match:
            notifyMatch()
        case .mismatch:
            if viewModel.inputCodeCurrLen() == 4 {
                alertCode("Code doesn't match. Press 4 new letters")
            }
        case .overflow:
            alertCode("Code is too long. Press 4 new letters")
            break
        case .forbidden:
            print("Verifying code is out of this state's scope")
        }
    }
    
    fileprivate func alertCode(_ message: String) {
        let alert = UIAlertController(title: "Wrong Code",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .cancel, handler: { _ in
            self.inputLabel.text?.removeAll()
            self.viewModel.flushInputCode()
        } ))
        self.present(alert, animated: true)
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
