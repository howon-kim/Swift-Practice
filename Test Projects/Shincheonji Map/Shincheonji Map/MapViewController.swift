//
//  MapViewController.swift
//  Shincheonji Map
//
//  Created by Howon Kim on 2/22/20.
//  Copyright © 2020 Howon Kim. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    var location: [Location] = []
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self

        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(location: initialLocation)
        
        
        // show artwork on map
        //let artwork = Location(title: "King David Kalakaua",
                              // coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
        //mapView.addAnnotation(artwork)
        
        
    }
    
    func loadInitialData() {
      // 1
      guard let fileName = Bundle.main.path(forResource: "data", ofType: "json")
        else { return }
      let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName))

      guard
        let data = optionalData,
        // 2
        let json = try? JSONSerialization.jsonObject(with: data),
        // 3
        let dictionary = json as? [String: Any],
        // 4
        let works = dictionary["data"] as? [[Any]]
        else { return }
      // 5
        let validWorks = works.compactMap { Location(json: $0) }
      location.append(contentsOf: validWorks)
    }
    
    
    
}
