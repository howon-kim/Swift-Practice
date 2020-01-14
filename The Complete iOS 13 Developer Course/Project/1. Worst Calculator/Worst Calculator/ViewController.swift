//
//  ViewController.swift
//  Worst Calculator
//
//  Created by Howon Kim on 1/8/20.
//  Copyright © 2020 Howon Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstValue: UITextField!
    @IBOutlet weak var secondValue: UITextField!
    @IBOutlet weak var result: UILabel!
    var resultValue : Int = 0
    

    
    @IBAction func add(_ sender: Any) {
        if let fValue = Int(firstValue.text!) {
            if let sValue = Int(secondValue.text!) {
                resultValue = fValue + sValue
                result.text = "Result: " + String(resultValue)
            }
        }
    }
    
    @IBAction func sub(_ sender: Any) {
        if let fValue = Int(firstValue.text!) {
            if let sValue = Int(secondValue.text!) {
                result.text = "Result: " + String(fValue - sValue)
            }
        }
    }
    
    @IBAction func mul(_ sender: Any) {
        if let fValue = Int(firstValue.text!) {
            if let sValue = Int(secondValue.text!) {
                result.text = "Result: " + String(fValue * sValue)
            }
        }
    }
    
    @IBAction func div(_ sender: Any) {
        if let fValue = Int(firstValue.text!) {
            if let sValue = Int(secondValue.text!) {
                result.text = "Result: " + String(fValue / sValue)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

