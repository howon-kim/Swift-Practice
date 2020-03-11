//
//  ReactionViewController.swift
//  coronamap
//
//  Created by Howon Kim on 2/2/20.
//  Copyright © 2020 Howon Kim. All rights reserved.
//

import UIKit

class ReactionViewController: UIViewController {

    @IBOutlet weak var backingImageView: UIImageView!
    // to store backing (snapshot) image
    var backingImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backingImageView.image = backingImage

    }
    


}
