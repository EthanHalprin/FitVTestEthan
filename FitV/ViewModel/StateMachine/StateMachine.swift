//
//  StateMachine.swift
//  FitV
//
//  Created by Ethan on 20/12/2020.
//
import Foundation


enum StateType: Int {
    case setup = 0
    case resetup = 1
    case practice = 2
}

protocol State {
    func transit(to target: StateType, sender: StateRespondibleViewController) -> Void
}

protocol StateRespondibleViewController {
    func next()
    func prev()
}

class EStateMachine {
    
    var current = StateType.setup
    var states  = [State]()
    
    init() {
        states.append(SetupState())
        states.append(ExerciseState())
        states.append(PresetupState())
        
        observe()
    }
    
    func observe() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(correctCodeIn),
                                               name: .correctCodeDidEnter,
                                               object: nil)
    }

    @objc func correctCodeIn(notification: Notification) {
        if let vc = notification.object as? StateRespondibleViewController {
            states[current.rawValue].transit(to: .practice, sender: vc)
            current = .practice
        }
    }
}

extension Notification.Name {
    static let correctCodeDidEnter = Notification.Name("CorrectCodeDidEnter")
    static let userdidPressStop    = Notification.Name("userdidPressStop")
}
