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

class FirstViewController: UIViewController {

    @IBOutlet weak var MapView: MKMapView!
    
    // Gets app delegate for use of its helper functions (usages such as location)
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var observer:  NSObjectProtocol?
    
    var marker: Marker?
    var annotation: MKPointAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

            annotation = MKPointAnnotation()
            annotation?.coordinate = coord
            
            centerMapOnLocation (location: location)
            MapView.addAnnotation (annotation!)
        }
        
        
        /* let marker = Marker (title: "Marker",
                             locationName:"Waikiki Gateway Park",
                             discipline: "Sculpture",
                             coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661)) */
        
        
    }

    func updateUserLocation(location: CLLocation) {
        
        
//        let marker = Marker (title: "Marker",
//                             locationName:"User Position",
//                             discipline: "You",
//                             coordinate: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
//        centerMapOnLocation (location: location)
//        MapView.addAnnotation (marker)

        if self.annotation != nil {
            self.annotation!.coordinate = location.coordinate
        
        }
        
    
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation (location: CLLocation) {
        let doubleRegionRadius = regionRadius * 2.0;
        let coordinateRadius = MKCoordinateRegionMakeWithDistance (
            location.coordinate, doubleRegionRadius, doubleRegionRadius)
        MapView.setRegion (coordinateRadius, animated:true)
    }

}
