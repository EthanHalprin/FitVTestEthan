//
//  ResetupState.swift
//  FitV
//
//  Created by Ethan on 21/12/2020.
//

import Foundation

class ResetupState: State {
    func transit(to target: StateType, sender: StateRespondibleViewController) -> Void {
        switch target {
        case .setup:
            break
        case .resetup:
            break
        case .practice:
            sender.next()
            break
        case .finish:
            break
        }
    }
}

extension ResetupState: CodeEvaluatable {
    func scan(_ code: String) -> Bool {
        return code == "BBB"
    }
}
