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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // set initlial location in Honolulu
        // let initialLocation = CLLocation(latitude: 21.28778, longitude: -157.829444)
        appDelegate.locationManager.requestWhenInUseAuthorization()
        appDelegate.locationManager.requestLocation()
        var coord: CLLocationCoordinate2D!
        coord = appDelegate.locationManager.location?.coordinate
        if (coord != nil) {
            let initialLocation = CLLocation(latitude: coord.latitude, longitude: coord.longitude)
            let marker = Marker (title: "Marker",
                                 locationName:"User Position",
                                 discipline: "You",
                                 coordinate: CLLocationCoordinate2D(latitude: coord.latitude, longitude: coord.longitude))
            centerMapOnLocation (location: initialLocation)
            MapView.addAnnotation (marker)
        }
        
        
        /* let marker = Marker (title: "Marker",
                             locationName:"Waikiki Gateway Park",
                             discipline: "Sculpture",
                             coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661)) */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation (location: CLLocation) {
        let doubleRegionRadius = regionRadius * 2.0;
        let coordinateRadius = MKCoordinateRegionMakeWithDistance (
            location.coordinate, doubleRegionRadius, doubleRegionRadius)
        MapView.setRegion (coordinateRadius, animated:true)
    }

}
