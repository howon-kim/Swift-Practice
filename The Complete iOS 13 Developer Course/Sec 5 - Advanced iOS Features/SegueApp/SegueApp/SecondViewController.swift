//
//  SecondViewController.swift
//  SegueApp
//
//  Created by Howon Kim on 1/14/20.
//  Copyright © 2020 Howon Kim. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var myName = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLabel.text = myName
    }
    


}
