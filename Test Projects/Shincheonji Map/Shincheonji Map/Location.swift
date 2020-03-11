//
//  Location.swift
//  Shincheonji Map
//
//  Created by Howon Kim on 2/23/20.
//  Copyright © 2020 Howon Kim. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class Location: NSObject {
    /**
     let geocoder = CLGeocoder()
     let locale = Locale(identifier: "Ko-kr")
     */
    
    let title: String?
    let address: String
    
    init?(json: [Any]) {
        // 1
        self.title = json[0] as? String ?? "No Title"
        // 2
        self.address = json[1] as! String
    }
}
