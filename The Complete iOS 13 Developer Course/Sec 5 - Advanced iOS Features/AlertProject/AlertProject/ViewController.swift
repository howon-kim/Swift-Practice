//
//  ViewController.swift
//  AlertProject
//
//  Created by Howon Kim on 1/14/20.
//  Copyright © 2020 Howon Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var password2Text: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signupClicked(_ sender: Any) {
        if (usernameText.text! == "") {
            makeAlert(titleInput: "Error", messageInput: "Username not found")
        } else if (passwordText.text! == "") {
            makeAlert(titleInput: "Error", messageInput: "Password not found")
        } else if (password2Text.text == "") {
            makeAlert(titleInput: "Error", messageInput: "Password not found")
        } else if (passwordText.text != password2Text.text) {
            makeAlert(titleInput: "Error", messageInput: "Password do not match")
        } else {
            makeAlert(titleInput: "Success", messageInput: "User Ok")
        }
        
    }
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)

        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { (UIAlertAction) in
            // Button clicked
            print("button clicked")
        }
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

