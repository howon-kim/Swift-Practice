//
//  KRMapViewController.swift
//  coronamap
//
//  Created by Howon Kim on 2/2/20.
//  Copyright © 2020 Howon Kim. All rights reserved.
//

import UIKit
import NMapsMap
import Firebase

class KRMapViewController: UIViewController, NMFMapViewDelegate {
    
        
    var mapView = NMFMapView()
    var infoWindow = NMFInfoWindow()
    var dataSource = NMFInfoWindowDefaultTextSource.data()
    var marker = [String: [NMFMarker]]()
    var loc = [String: [NMGLatLng]]()
    var documentIdArray = [String]()
    var desc = [NMFMarker: String]()
    var patientNum = [NMFMarker: String]()
    var infectionNum = [NMFMarker: String]()



    @IBOutlet weak var bottomImage: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var patientLabel: UILabel!
    @IBOutlet weak var infectionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mapView = NMFMapView(frame: view.frame)
        mapView.delegate = self
        getDataFromFirestore()
        
        view.addSubview(mapView)
        view.addSubview(bottomImage)
        view.addSubview(descLabel)
        view.addSubview(patientLabel)
        view.addSubview(infectionLabel)

                
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: 36.3504, lng: 127.3845), zoomTo: 6.0)
        cameraUpdate.animation = .fly
        mapView.moveCamera(cameraUpdate)
        //marker.touchHandler = handler
        
        
        

    }
    
    func getDataFromFirestore() {
           
           let fireStoreDatabase = Firestore.firestore()
           fireStoreDatabase.collection("KR").addSnapshotListener { (snapshot, error) in
               if error != nil {
                   self.makeAlert(titleInput: "내부 오류", messageInput: error?.localizedDescription ?? "내부 오류가 발생하였습니다")
               } else {
                   if snapshot?.isEmpty != true && snapshot != nil{
                       //self.desc.removeAll(keepingCapacity: false)
                       //self.loc.removeAll(keepingCapacity: false)

                       /**
                               파이어베이스 차량관련 변수이름
                               desc : 설명
                               loc :  위치
                        */
                       
                       for document in snapshot!.documents {
                            let documentID = document.documentID
                            self.documentIdArray.append(documentID)

                            if let _location = document.get("Location") as? [GeoPoint] {
                                self.convertLocation(documentID: documentID, location: _location)
                                self.addMarker(documentID: documentID)
                                self.addRoute(documentID: documentID)
                                self.addCircle(documentID: documentID)
                            }
                            if let _caption = document.get("Caption") as? [String] {
                                self.addCaption(documentID: documentID, caption: _caption)
                            }
                            
                            if let _description = document.get("Description") as? [String] {
                                self.addInfoWindow(documentID: documentID, description: _description)

                            }
                        
                        if let _touching = document.get("Touching") as? String {
                            self.addTouchingNum(documentID: documentID, touching: _touching)

                        }
                    }
               }
           }
       }
    }
    
    func convertLocation(documentID: String, location: [GeoPoint]) {
        self.loc[documentID] = [NMGLatLng]()
        for convertedLoc in location {
            self.loc[documentID]!.append(NMGLatLng(lat: convertedLoc.latitude, lng: convertedLoc.longitude))
        }
        print(self.loc[documentID]!.count)
    }

    func addMarker(documentID: String) {
        self.marker[documentID] = [NMFMarker]()
        let color = UIColor.random()
        for loc in self.loc[documentID]! {
            let marker = NMFMarker()
            marker.position = loc
            // 색상변경 : 검정에서 가산
            marker.iconImage = NMF_MARKER_IMAGE_BLACK
            marker.iconTintColor = color
            //
            marker.mapView = mapView
            marker.touchHandler = handler
            patientNum[marker] = documentID
            self.marker[documentID]!.append(marker)
        }


    }
    func addTouchingNum(documentID: String, touching: String) {
        var index = 0
        if let totalMarker = self.marker[documentID] as? [NMFMarker]{
            for marker in totalMarker {
                infectionNum[marker] = touching
            }
        }
    }

    
    func addCaption(documentID: String, caption: [String]) {
        var index = 0
        if let totalMarker = self.marker[documentID] as? [NMFMarker]{
            for marker in totalMarker {
                marker.captionText = documentID
                marker.subCaptionText = caption[index]
                marker.subCaptionColor = UIColor.blue
                marker.subCaptionHaloColor = UIColor(red: 200.0/255.0, green: 1, blue: 200.0/255.0, alpha: 1)
                marker.subCaptionTextSize = 10
                index += 1
                //self.marker[documentID]?.append(marker)
                }
        }


    }
    
    func addInfoWindow(documentID: String, description: [String]) {
        var index = 0
        if let totalMarker = self.marker[documentID] as? [NMFMarker]{
            for des in description {
                self.desc[totalMarker[index]] = des
                index += 1
                /*
                dataSource.title = des
                print(des)
                infoWindow.dataSource = dataSource
                for marker in self.marker[documentID]! {
                    infoWindow.open(with: marker)
                }
                 */
            }
        }
    }
    
    func addCircle(documentID: String) {
        let color = UIColor.random()
        for loc in self.loc[documentID]! {
            let circle = NMFCircleOverlay(loc, radius: 750, fill: color)
            circle.mapView = mapView
        }
    }
    
    func addRoute(documentID: String) {
        let arrowheadPath = NMFArrowheadPath()
        arrowheadPath.points = self.loc[documentID]!
        arrowheadPath.mapView = mapView
    }

    
    // 지도를 탭하면 정보 창을 닫음
    func didTapMapView(_ point: CGPoint, latLng latlng: NMGLatLng) {
        infoWindow.close()
    }
    
    // 마커를 탭하면:
    func handler (overlay: NMFOverlay) -> Bool {
        if let marker = overlay as? NMFMarker {
            
            if marker.infoWindow == nil {
                // 현재 마커에 정보 창이 열려있지 않을 경우 엶
                //self.infoWindow.open(with: marker)
                displayDescription(marker: marker)

            } else {
                // 이미 현재 마커에 정보 창이 열려있을 경우 닫음
                self.infoWindow.close()
            }
 
        }
        return true
    }
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func displayDescription(marker: NMFMarker) {
        bottomImage.isHidden = false
        descLabel.isHidden = false
        infectionLabel.isHidden = false
        patientLabel.isHidden = false
        descLabel.text = self.desc[marker]
        patientLabel.text = self.patientNum[marker]
        infectionLabel.text = "접촉자: \(self.infectionNum[marker]!)"
    }
    
    
    func displayActionSheet(marker: NMFMarker) {
         
        // 1
        let optionMenu = UIAlertController(title: nil, message: self.desc[marker], preferredStyle: .actionSheet)
            
        // 2
        let deleteAction = UIAlertAction(title: "Delete", style: .default)
        let saveAction = UIAlertAction(title: "Save", style: .default)
            
        // 3
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            
        // 4
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
            
        // 5
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func reactionListButtonTapped() {
      guard let reactionVC = storyboard?.instantiateViewController(withIdentifier: "ReactionViewController")
      as? ReactionViewController else {
          assertionFailure("No view controller ID ReactionViewController in storyboard")
          return
      }
      

      // take a snapshot of current view and set it as backingImage
        reactionVC.backingImage = self.view.asImage()
        
      // present the view controller modally without animation
      self.present(reactionVC, animated: false, completion: nil)
    }

    
}
