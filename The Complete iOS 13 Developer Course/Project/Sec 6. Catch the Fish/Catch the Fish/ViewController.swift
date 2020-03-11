//
//  ViewController.swift
//  Catch the Fish
//
//  Created by Howon Kim on 1/14/20.
//  Copyright © 2020 Howon Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var timer = Timer()
    var currentTime : Int = 20
    var score : Int = 0
    
    var randX = 0
    var randY = 0
    var fishImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = String(currentTime)
        // Do any additional setup after loading the view.
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        regenFish()
        let storedScore = UserDefaults.standard.object(forKey: "highscore")
        
        // Casting - as? vs as!
        if let myHighScore = storedScore as? Int {
            highScoreLabel.text = "High Score: \(myHighScore)"
        }
    }
    

    
    @objc func regenFish() {
        scoreLabel.text = "Score: \(score)"
        if (currentTime <= 0) {
            fishImageView.removeFromSuperview()
        } else {
            fishImageView.removeFromSuperview()
            randX = Int.random(in: 100...Int(view.frame.size.width) - 100)
            randY = Int.random(in: 100...Int(view.frame.size.height) - 100)
            fishImageView = UIImageView(frame: CGRect(x: randX, y: randY, width: 100, height: 50))
            fishImageView.image = UIImage(named: "fish1")
            fishImageView.isUserInteractionEnabled = true
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(regenFish))
            fishImageView.addGestureRecognizer(gestureRecognizer)
            self.view.addSubview(fishImageView)
            score += 1
        }
    }
    
    
    @objc func timerFunc() {
        if currentTime <= 0 {
            score -= 1
            timer.invalidate()
            timeLabel.text = "Time's Over!"

            let storedScore = UserDefaults.standard.object(forKey: "highscore")
            // Casting - as? vs as!
            if let myHighScore = storedScore as? Int {
                if (myHighScore < score) {
                    highScoreLabel.text = "High Score: \(score)"
                    UserDefaults.standard.set(score, forKey: "highscore")
                }
                print("\(myHighScore)  \(score)")
            } else {
                UserDefaults.standard.set(score, forKey: "highscore")
                highScoreLabel.text = "High Score: \(score)"
            }
        } else {
            // Decrease Time
            currentTime -= 1
            timeLabel.text = String(currentTime)
        }
    }
}
