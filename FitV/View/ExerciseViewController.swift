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
        setup()
        runExercises()
    }
}

extension ExerciseViewController {
    
    fileprivate func setup() {
        self.navigationItem.hidesBackButton = true
        pauseButton.layer.cornerRadius = 9.0
        pauseButton.layer.borderColor = UIColor.white.cgColor
        pauseButton.layer.borderWidth = 2.5
        guard let workoutImageView = UIImageView.fromGif(frame: CGRect(x: 40, y: 250, width: 300, height: 300),
                                                         resourceName: "workout") else {
            return
        }
        workoutImageView.animationDuration = 1
        view.addSubview(workoutImageView)
        NSLayoutConstraint.activate([
            workoutImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            workoutImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
         ])

        workoutImageView.startAnimating()
    }
    
    func runExercises() {
        
        //  !!!
        // This is just psuedo placeholder - In reality of course it is required to show
        // video or AR scene for each with timer
        // !!!
        if let exercises = viewModel.exersicesContainer?.exercises {
            for exercise in exercises {
                print("Running exercise \(exercise.name) for \(exercise.totalTime)")
                _ = Timer.scheduledTimer(timeInterval: TimeInterval(exercise.totalTime),
                                                     target: self,
                                                     selector: #selector(onTimer),
                                                     userInfo: nil, repeats: false)
            }
        }
        
    }
    
    @objc func onTimer() {}

    
    fileprivate func alert() {
        let alert = UIAlertController(title: "PAUSE",
                                      message: "Choose whether to pause (you can resume it later, which will require a new code) or just to finish it as is",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Pause", style: .cancel, handler: { _ in
            NotificationCenter.default.post(name    : .userDidPause,
                                            object  : self,
                                            userInfo: nil)
        } ))
        
        alert.addAction(UIAlertAction(title: "Finish", style: .destructive, handler: { _ in
            NotificationCenter.default.post(name    : .userDidFinish,
                                            object  : self,
                                            userInfo: nil)
        } ))

        self.present(alert, animated: true)
    }
}

extension UIImageView {
    static func fromGif(frame: CGRect, resourceName: String) -> UIImageView? {
        guard let path = Bundle.main.path(forResource: resourceName, ofType: "gif") else {
            print("Gif does not exist at that path")
            return nil
        }
        let url = URL(fileURLWithPath: path)
        guard let gifData = try? Data(contentsOf: url),
            let source =  CGImageSourceCreateWithData(gifData as CFData, nil) else { return nil }
        var images = [UIImage]()
        let imageCount = CGImageSourceGetCount(source)
        for i in 0 ..< imageCount {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: image))
            }
        }
        let gifImageView = UIImageView(frame: frame)
        gifImageView.animationImages = images
        return gifImageView
    }
}

extension ExerciseViewController: StateRespondibleViewController {
    func prev() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func next() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let completeVC = storyBoard.instantiateViewController(withIdentifier: "CompleteViewController") as! CompleteViewController
        //
        // Here we will analyze results how much user made when have video
        // and set 'acheivement' accordingly
        //
        completeVC.acheivement = .wellDone
        
        self.navigationController?.pushViewController(completeVC, animated: true)
    }
}
