//
//  ViewController.swift
//  GestureRecognizerApp
//
//  Created by Howon Kim on 1/14/20.
//  Copyright © 2020 Howon Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var isJames = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changePic))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func changePic() {
        if isJames {
            imageView.image = UIImage(named: "c2")
            myLabel.text = "ColdPlay Group"
            isJames = false
        } else {
            imageView.image = UIImage(named: "c1")
            myLabel.text = "ColdPlay Solo"
            isJames = true
        }
    }


}

