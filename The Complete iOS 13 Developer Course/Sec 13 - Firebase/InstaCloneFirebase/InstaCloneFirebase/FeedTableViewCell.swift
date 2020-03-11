//
//  FeedTableViewCell.swift
//  InstaCloneFirebase
//
//  Created by Howon Kim on 1/18/20.
//  Copyright © 2020 Howon Kim. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var documentIdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func likeButtonClicked(_ sender: Any) { // 세차 평가에 이용할 수 있음.
        print("like button clicked")
        let fireStoreDataBase = Firestore.firestore()
        if let likeCount = Int(likeLabel.text!) {
            let likeStore = ["likes": likeCount + 1] as [String : Any]
            fireStoreDataBase.collection("Posts").document(documentIdLabel.text!).setData(likeStore, merge: true)

        }
        
        
        
    }
    
}
