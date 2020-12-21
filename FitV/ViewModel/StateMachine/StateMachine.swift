//
//  StateMachine.swift
//  FitV
//
//  Created by Ethan on 20/12/2020.
//
import Foundation

class EStateMachine {
    
    var current = StateType.setup
    var states  = [State]()
    
    init() {
        states.append(SetupState())
        states.append(ResetupState())
        states.append(ExerciseState())
        states.append(CompletedState())

        fixObservers()
    }
    
    fileprivate func fixObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(correctCodeIn),
                                               name: .correctCodeDidEnter,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(userCompleted),
                                               name: .userDidFinish,
                                               object: nil)
    }
}

extension EStateMachine {
    
    @objc func correctCodeIn(notification: Notification) {
        if let vc = notification.object as? StateRespondibleViewController {
            states[current.rawValue].transit(to: .practice, sender: vc)
            current = StateType.practice
        }
    }
    
    @objc func userCompleted(notification: Notification) {
        if let vc = notification.object as? StateRespondibleViewController {
            states[current.rawValue].transit(to: .finish, sender: vc)
            current = StateType.finish
        }
    }
}

extension Notification.Name {
    
    static let correctCodeDidEnter = Notification.Name("CorrectCodeDidEnter")
    static let userDidFinish = Notification.Name("UserDidFinish")
}
