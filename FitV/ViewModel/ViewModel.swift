//
//  ViewModel.swift
//  FitV
//
//  Created by Ethan on 20/12/2020.
//

import Foundation
import Combine


class ViewModel {
    
    let stateMachine = StateMachine()

    fileprivate var codesKeeper: SequenceCodesKeeper?
    var exersicesContainer: ExercisesBundle?
    fileprivate var cancellable: AnyCancellable?
    
    func flushInputCode() {
        codesKeeper?.flush()
    }
    
    func inputCodeCurrLen() -> Int {
        var len = 0
        if let coder = codesKeeper {
            len = coder.currCode.count
        }
        return len
    }
    
    func scanCode(_ adder: String) -> ScanResult {
        if let coder = codesKeeper {
            return coder.concatAndTest(adder, state: stateMachine.current)
        } else {
            return ScanResult.codesUnavailable
        }
    }
    
    func fetch(_ urlString: String) throws {
        
        guard let url = URL(string: urlString) else {
            fatalError("Bad url for exercises")
        }
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                          httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: ExercisesBundle.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main) 
            .sink(receiveCompletion: { completionError in
                switch completionError {
                    case .failure(let error):
                        print(error.localizedDescription)
                    case .finished:
                    break
                }
            }) { bundle in
                dump(bundle)
                self.exersicesContainer = bundle
                self.parseCodes()
                self.cancellable = nil
        }
    }
}
extension ViewModel {
    fileprivate func parseCodes() {
        if let container = self.exersicesContainer {
            self.codesKeeper = SequenceCodesKeeper(codeLen: container.setupSequence.count)
            self.codesKeeper!.setupSequence = container.setupSequence
            for seq in container.reSetupSequence {
                self.codesKeeper!.resetupSequences.append(String(seq.code))
            }
        }
    }
}

enum ScanError: Error {
    case codesBaseUnavailable
    case notCodeEvaluater
    case wrongCode
    case isOutOfBounds
}
