//
//  CompleteViewController.swift
//  FitV
//
//  Created by Ethan on 21/12/2020.
//

import UIKit
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class CompleteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        post()
    }
}
extension CompleteViewController {

    /*
        Hardcoded exercise for now, but received Status Code: 200 OK
     */
    func post() {
        let parameters = "{\n    \"total_time_completed\" : 1,\n    \"exercises_completed\" : {\n        \"name\" : \"squat\",\n        \"total_time\" : 20 \n    }\n}"
        let postData = parameters.data(using: .utf8)
        var request = URLRequest(url: URL(string: "https://ios-interviews.dev.fitvdev.com/addWorkoutSummary")!,timeoutInterval: Double.infinity)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            if let resp = response {
                dump(resp)
            }
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
}
