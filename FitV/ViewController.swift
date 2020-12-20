//
//  ViewController.swift
//  FitV
//
//  Created by Ethan on 20/12/2020.
//

import UIKit

class ViewController: UIViewController {

    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didPressStop),
                                               name: .userdidPressStop, object: nil)
    }
    
    @objc func didPressStop(notification: Notification) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func stopTouchUpInside(_ sender: UIButton) {
        
    }
    
}

