//
//  FirstViewController.swift
//  Preventanyl
//
//  Created by Yudhvir Raj on 2017-09-28.
//  Copyright © 2017 Yudhvir Raj. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import UserNotifications
import Firebase
import FirebaseDatabase

class FirstViewController: UIViewController {
    
    @IBOutlet weak var MapView: MKMapView!
    
    // Gets app delegate for use of its helper functions (usages such as location)
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var observer:  NSObjectProtocol?
    
    var centered: Bool = false
    
    //var marker: Marker?
    var selfAnnotation: MKPointAnnotation?
    
    var staticKitMarkerMap: Dictionary<Int32, Marker> = Dictionary<Int32, Marker>()
    
    
    // firebase database refs
    lazy var ref: DatabaseReference = Database.database().reference()
    var staticKitsRef: DatabaseReference!
    //all the static kits
    var allStaticKits: [StaticKit]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //firebase database reference of statickits
        staticKitsRef = ref.child("statickits")
        
        // Do any additional setup after loading the view, typically from a nib.
        // set initlial location in Honolulu
        // let initialLocation = CLLocation(latitude: 21.28778, longitude: -157.829444)
        
        
        observer = Notifications.addObserver(messageName: Location.LOCATION_CHANGED, object: nil) { _ in
            self.updateUserLocation(location: Location.currentLocation)
        }
        
        appDelegate.locationManager.requestWhenInUseAuthorization()
        appDelegate.locationManager.requestLocation()
        var coord: CLLocationCoordinate2D!
        coord = appDelegate.locationManager.location?.coordinate
        if (coord != nil) {
            let location = CLLocation(latitude: coord.latitude, longitude: coord.longitude)
            
            //            marker = Marker (title: "Marker",
            //                                 locationName:"User Position",
            //                                 discipline: "You",
            //                                 coordinate: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude:  location.coordinate.longitude))
            
            selfAnnotation = MKPointAnnotation()
            selfAnnotation?.coordinate = coord
            
            centerMapOnLocation (location: location)
            MapView.addAnnotation (selfAnnotation!)
        }
        
        
        /* let marker = Marker (title: "Marker",
         locationName:"Waikiki Gateway Park",
         discipline: "Sculpture",
         coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661)) */
        
        
    }
    
    func updateUserLocation(location: CLLocation) {
        
        if !centered {
            centerMapOnLocation(location: location)
        }
        centered = true
        
        //        let marker = Marker (title: "Marker",
        //                             locationName:"User Position",
        //                             discipline: "You",
        //                             let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
        //        centerMapOnLocation (location: location)
        //        MapView.addAnnotation (marker)
        
        if self.selfAnnotation != nil {
            self.selfAnnotation!.coordinate = location.coordinate
            
        }
        
        
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation (location: CLLocation) {
        let doubleRegionRadius = regionRadius * 2.0;
        let coordinateRadius = MKCoordinateRegionMakeWithDistance (
            location.coordinate, doubleRegionRadius, doubleRegionRadius)
        MapView.setRegion (coordinateRadius, animated:true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        allStaticKits = [StaticKit]()
        
        // Listen for new staticKits in the Firebase database
        //////it is aysn.kits will be added one by one;
        //
        staticKitsRef.observe(.childAdded, with: {[weak self] (snapshot) -> Void in
            
            print("childAdded")
            
            if let addedskit = StaticKit(From: snapshot) {
                
                
                guard let id = Int32(addedskit.id) else {
                    print("kit id (\(addedskit.id)) is not an int! Skipping!")
                    return
                }
                
                self?.allStaticKits.append(addedskit)
                
                let newMarker = Marker (title: addedskit.displayName,
                                        locationName: "\(addedskit.address.streetAddress) \(addedskit.address.city)",
                                        discipline: "Static Kit",
                                        coordinate: CLLocationCoordinate2D(latitude: addedskit.coordinates.lat, longitude: addedskit.coordinates.long))
                self?.MapView.addAnnotation(newMarker)
                self?.staticKitMarkerMap[id] = newMarker
                
                //debug info
                print("start printing\n")
                print(addedskit)
                print("\(self?.allStaticKits.count ?? -1)")
            }
            
        })
        
        // Listen for deleted staticKits in the Firebase database
        staticKitsRef.observe(.childRemoved, with: { [weak self] (snapshot) -> Void in
            
            print("childRemoved")
            
            //get  value as dictionary
            guard let dict = snapshot.value as? [String:Any] else {
                print("childRemoved: Unable to parse snapshot.value from firebase!")
                return
            }
            //get the userid
            guard let rmuid = dict["userId"] as? String else {
                print("childRemoved: userId not found!")
                return
            }
            //remove
            guard let kit = StaticKit(From: snapshot) else {
                print("childRemoved: Unable to parse Kit from firebase!")
                return
            }
            guard let id = Int32(kit.id) else {
                print("Invalid id not an int: (\(kit.id)). Unable to remove!")
                return
            }
            self?.staticKitMarkerMap.removeValue(forKey: id)
            if let index = self?.allStaticKits.index(where: {$0.userId == rmuid}) {
                self?.allStaticKits.remove(at: index)
            }
        })
        // Listen for deleted staticKits in the Firebase database
        staticKitsRef.observe(.childChanged, with: { [weak self] (snapshot) -> Void in
            
            print("childChanged")
            
            
            //remove
            guard let dict = snapshot.value as? [String:Any] else { return }
            guard let changeuid = dict["userId"] as? String else {return }
            if let index = self?.allStaticKits.index(where: {$0.userId == changeuid}) {
                self?.allStaticKits.remove(at: index)
            }
            //add back
            if let addedskit = StaticKit(From: snapshot) {
                self?.allStaticKits.append(addedskit)
//                print("start printing\n")
//                print(addedskit)
//                print("\(self?.allStaticKits.count ?? -1)")
            }
            
            
        })
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        staticKitsRef.removeAllObservers()
    }
}

