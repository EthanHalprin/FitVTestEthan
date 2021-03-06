//
//  SetUpViewController.swift
//  FitV
//
//  Created by Ethan on 20/12/2020.
//
import UIKit


class SetUpViewController: UIViewController {
    
    var viewModel = ViewModel()
    
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var keyA: UIButton!
    @IBOutlet weak var keyB: UIButton!
    @IBOutlet weak var keyC: UIButton!
    @IBOutlet weak var keyD: UIButton!
    @IBOutlet weak var keyE: UIButton!
    @IBOutlet weak var keyF: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setup()
        
        do {
            try viewModel.fetch("https://ios-interviews.dev.fitvdev.com/getWorkoutDetails")
        } catch {
            fatalError("Could not load exercises")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toggleNumKeys(viewModel.stateMachine.current == StateType.resetup)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.inputTextField.text?.removeAll()
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
    
    fileprivate func setup() {
        inputTextField.inputView = UIView()
        inputTextField.isEnabled = false
        keyA.layer.cornerRadius = 7.0
        keyB.layer.cornerRadius = 7.0
        keyC.layer.cornerRadius = 7.0
        keyD.layer.cornerRadius = 7.0
        keyE.layer.cornerRadius = 7.0
        keyF.layer.cornerRadius = 7.0
    }
    
    fileprivate func notifyMatch() {
        NotificationCenter.default.post(name    : .correctCodeDidEnter,
                                        object  : self,
                                        userInfo: nil)
    }
    
    fileprivate func didUserTouchUpInside(_ input: String) {
        inputTextField.text! += "*"
        var adder = String()
        if viewModel.stateMachine.current == StateType.resetup {
            adder = String(Array(input)[0].asciiValue! - Array("a")[0].asciiValue! + 1)
        } else {
            adder = input
        }
        let result = viewModel.scanCode(adder)
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
            self.inputTextField.text?.removeAll()
            self.viewModel.flushInputCode()
        } ))
        self.present(alert, animated: true)
    }
    
    fileprivate func toggleNumKeys(_ isNumeric: Bool) {
        if isNumeric {
            keyA.setTitle("1", for: .normal)
            keyB.setTitle("2", for: .normal)
            keyC.setTitle("3", for: .normal)
            keyD.setTitle("4", for: .normal)
            keyE.setTitle("5", for: .normal)
            keyF.setTitle("6", for: .normal)
        } else {
            keyA.setTitle("A", for: .normal)
            keyB.setTitle("B", for: .normal)
            keyC.setTitle("C", for: .normal)
            keyD.setTitle("D", for: .normal)
            keyE.setTitle("E", for: .normal)
            keyF.setTitle("F", for: .normal)
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
    
    func prev() {
    }
}
