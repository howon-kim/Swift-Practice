//
//  ImageViewController.swift
//  LandmarkBook
//
//  Created by Howon Kim on 1/15/20.
//  Copyright © 2020 Howon Kim. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var landmarkLabel: UILabel!
    
    var selectedLanmarkName = ""
    var selectedLandmarkImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        landmarkLabel.text = selectedLanmarkName
        imageView.image = selectedLandmarkImage
    }
    

}
