//
//  ViewController.swift
//  TimerProject
//
//  Created by Howon Kim on 1/14/20.
//  Copyright © 2020 Howon Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer = Timer()
    var counter = 0
    @IBOutlet weak var timeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        counter = 10
        timeLabel.text = "Time: \(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
    }
    
    @objc func timerFunction() {
        timeLabel.text = "Time: \(counter)"
        counter -= 1
        
        if counter == 0 {
            timer.invalidate()
            timeLabel.text = "Time's Over"
        }
    }

    @IBAction func buttonClicked(_ sender: Any) {
        print("button clicked")
    }
    
}

