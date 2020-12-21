//
//  ViewModel.swift
//  FitV
//
//  Created by Ethan on 20/12/2020.
//

import Foundation
import Combine


class ViewModel {
    
    fileprivate var userCode = ""
    fileprivate var stateMachine = StateMachine()
    fileprivate var exersices = [Exercise]()
    fileprivate var cancellable: AnyCancellable?
}

extension ViewModel {

    func scanCode(_ addenda: String) -> Notification.Name? {
        
        guard stateMachine.states[stateMachine.current.rawValue] is CodeEvaluatable else {
            return nil
        }
        
        userCode += addenda
        var notificationName: Notification.Name?
        
        if (stateMachine.states[stateMachine.current.rawValue] as! CodeEvaluatable).scan(userCode) {
            notificationName = .correctCodeDidEnter
            userCode.removeAll()
        }
        
        return notificationName
    }
    
    func fetchExercises(_ urlString: String) throws {
        
        guard let url = URL(string: urlString) else {
            print("ERROR: No url")
            return
        }
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            //.map { $0.data }
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                          httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: [Exercise].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main) 
            .sink(receiveCompletion: { completionError in
                switch completionError {
                    case .failure(let error):
                        print(error.localizedDescription)
                    case .finished:
                    break
                }
            }) { exers in
                dump(exers)
                self.exersices = exers
                self.cancellable = nil
        }
    }
    
    func checkCodes(_ lookup: String) -> Bool {
        // go thru exercises fetched and see if have code
        // ...
        return false
    }
}
