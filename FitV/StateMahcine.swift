//
//  StateMahcine.swift
//  FitV
//
//  Created by Ethan on 20/12/2020.
//

import Foundation
import Stateful

enum EventType {
    case start
    case finish
    case pause
    case resume
}

enum StateType {
    case setup
    case resetup
    case practice
}


class UserState {
    let machine = StateMachine<StateType, EventType>(initialState: .setup)
}
