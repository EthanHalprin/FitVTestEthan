//
//  SetupState.swift
//  FitV
//
//  Created by Ethan on 21/12/2020.
//

import Foundation

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
