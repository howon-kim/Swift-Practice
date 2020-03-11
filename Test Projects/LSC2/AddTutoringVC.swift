//
//  AddTutoringVC.swift
//  LSC
//
//  Created by Howon Kim on 2/1/20.
//  Copyright © 2020 Howon Kim. All rights reserved.
//

import UIKit
import Firebase

class AddTutoringVC: UIViewController {

    @IBOutlet weak var timeText: UITextField!
    @IBOutlet weak var tutorText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        let firestoreDatabase = Firestore.firestore()
        var firestoreReference: DocumentReference? = nil
        
        
        if tutorText.text == "" {
            makeAlert(titleInput: "Error", messageInput: "Enter the tutor")
        } else if tutorText.text == "" {
            makeAlert(titleInput: "Error", messageInput: "Enter the time")
        } else {
            // 새로 만들시 //
            let firestorePost = ["user" : Auth.auth().currentUser!.email!, "tutor" : self.tutorText.text!, "time": self.timeText.text!,  "date" : FieldValue.serverTimestamp()] as [String: Any]
            
            firestoreReference = firestoreDatabase.collection("Schedule").addDocument(data: firestorePost, completion: { (error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Internal Error")
                } else {
                    self.makeAlert(titleInput: "Success", messageInput: "Tutoring has added to database")
                }
            })
        }
    }
    


// Utils
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
