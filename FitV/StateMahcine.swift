//
//  StateMahcine.swift
//  FitV
//
//  Created by Ethan on 20/12/2020.
//
import Foundation
import UIKit

enum StateType: Int {
    case setup = 0
    case resetup = 1
    case practice = 2
}

protocol StateRespondibleViewController {
    func next()
    func prev()
}

protocol State {
    func transit(to target: StateType, sender: StateRespondibleViewController) -> Void
}

class SetupState: State {
    func transit(to target: StateType, sender: StateRespondibleViewController) -> Void {
        switch target {
        case .setup:
            break
        case .resetup:
            break
        case .practice:
            sender.next()
        }
    }
}

class ExerciseState: State {
    func transit(to target: StateType, sender: StateRespondibleViewController) -> Void {
        switch target {
        case .setup:
            break
        case .resetup:
            sender.prev()
        case .practice:
            break
        }
    }
}

class SummaryState: State {
    func transit(to target: StateType, sender: StateRespondibleViewController) -> Void {
        switch target {
        case .setup:
            break
        case .resetup:
            break
        case .practice:
            break
        }
    }
}

class EStateMachine {
    
    var current = StateType.setup
    var states  = [State]()
    
    init() {
        states.append(SetupState())
        states.append(ExerciseState())
        states.append(SummaryState())
        
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
    static let userdidPressStop = Notification.Name("userdidPressStop")
}
