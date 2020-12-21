//
//  StateDefs.swift
//  FitV
//
//  Created by Ethan on 21/12/2020.
//

import Foundation

enum StateType: Int {
    case setup = 0
    case resetup = 1
    case practice = 2
    case finish = 3
}

protocol State {
    func transit(to target: StateType,
                 sender: StateRespondibleViewController) -> Void
}

protocol StateRespondibleViewController {
    func next()
    func prev()
}
