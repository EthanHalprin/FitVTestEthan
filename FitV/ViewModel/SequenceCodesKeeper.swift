//
//  SequenceCodesKeeper.swift
//  FitV
//
//  Created by Ethan on 21/12/2020.
//

import Foundation


enum ScanResult {
    case codesUnavailable
    case match
    case mismatch
    case overflow
    case forbidden
}
class SequenceCodesKeeper {
    
    var codeStandardLen: Int
    var currCode = ""
    var setupSequence = ""
    var resetupSequences = [String]()
    
    init(codeLen: Int) {
        codeStandardLen = codeLen
    }
    
    func concatAndTest(_ adder: String, state: StateType) -> ScanResult {
        guard state == .setup || state == .resetup else {
            return .forbidden
        }
        
        guard setupSequence.count > 0 && resetupSequences.count > 0 else {
            return .codesUnavailable
        }
    
        currCode += adder
        
        guard currCode.count <= codeStandardLen else {
            flush()
            return .overflow
        }
        
        if (state == .setup   && setupSequence == currCode) ||
           (state == .resetup && resetupSequences.contains(currCode)) {
            flush()
            return .match
        } else {
            return .mismatch
        }
    }
    
    func flush() {
        currCode.removeAll()
    }
}
