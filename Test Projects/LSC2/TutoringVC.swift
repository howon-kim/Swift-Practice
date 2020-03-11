//
//  TutoringVC.swift
//  LSC
//
//  Created by Howon Kim on 2/18/20.
//  Copyright © 2020 Howon Kim. All rights reserved.
//

import UIKit
import Firebase

class TutoringVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TutoringTableViewCell
        cell.tutorLabel.text = tutor[indexPath.row]
        
        
        
        let date = time[indexPath.row].dateValue()
        // Util : Date to String Value //
        let dateFormatter = DateFormatter()
        let timezone = TimeZone.current.abbreviation() ?? "PST"  // get current TimeZone abbreviation or set to CET
        dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        // Util : Date to String Value //

        
        cell.timeLabel.text = strDate
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return documentIdArray.count
    }
    
        
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section1"
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    var tutor = [String]()
    var time = [Timestamp]()
    var register = [String]()
    var waitlist = [String]()
    var documentIdArray : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getDataFromFirestore()
    }
    
    func getDataFromFirestore() {
        
        let fireStoreDatabase = Firestore.firestore()
        fireStoreDatabase.collection("Tutoring").order(by: "Time", descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil {
                self.makeAlert(titleInput: "Internal Error", messageInput: error?.localizedDescription ?? "Please bare with us")
            } else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.tutor.removeAll(keepingCapacity: false)
                    self.time.removeAll(keepingCapacity: false)
                   
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        self.documentIdArray.append(documentID)

                        if let _tutor = document.get("Tutor") as? String {
                            self.tutor.append(_tutor)
                        }
                        if let _time = document.get("Time") as? Timestamp {
                            print(Timestamp.dateValue(_time)())
                            print(Date())

                            self.time.append(_time)
                        }
                        if let _register = document.get("Register") as? String {
                            self.register.append(_register)
                        }
                        if let _waitlist = document.get("Waitlist") as? String {
                            self.waitlist.append(_waitlist)
                        }
                    }
                    
                    self.tableView.reloadData()
 

                }
            }
        }
    }
            
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}
