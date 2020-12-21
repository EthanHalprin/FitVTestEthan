//
//  ExerciseViewController.swift
//  FitV
//
//  Created by Ethan on 20/12/2020.
//

import UIKit

class ExerciseViewController: UIViewController {

    var viewModel: ViewModel!
    @IBOutlet var pauseButton: UIButton!
    
    @IBAction func pauseTouchUpInside(_ sender: UIButton) {
        alert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }

}

extension ExerciseViewController {
    
    fileprivate func alert() {
        let alert = UIAlertController(title: "PAUSE",
                                      message: "Choose whether to pause (you can resume it later, which will require a new code) or just to finish it as is",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Pause", style: .cancel, handler: { _ in self.pause()} ))
        alert.addAction(UIAlertAction(title: "Finish", style: .destructive, handler: { _ in self.finish()} ))

        self.present(alert, animated: true)
    }
    
    fileprivate func pause() {
        
    }

    fileprivate func finish() {
        NotificationCenter.default.post(name    : .userDidFinish,
                                        object  : self,
                                        userInfo: nil)
    }
}

extension ExerciseViewController: StateRespondibleViewController {
    
    func next() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let completeVC = storyBoard.instantiateViewController(withIdentifier: "CompleteViewController") as! CompleteViewController
        self.navigationController?.pushViewController(completeVC, animated: true)
    }
    
    func prev() { }
}
