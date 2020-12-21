//
//  SetupState.swift
//  FitV
//
//  Created by Ethan on 21/12/2020.
//

import Foundation

class PresetupState: State {
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
