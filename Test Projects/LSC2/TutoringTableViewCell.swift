//
//  TutoringTableViewCell.swift
//  LSC
//
//  Created by Howon Kim on 2/18/20.
//  Copyright © 2020 Howon Kim. All rights reserved.
//

import UIKit

class TutoringTableViewCell: UITableViewCell {

    @IBOutlet weak var tutorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
