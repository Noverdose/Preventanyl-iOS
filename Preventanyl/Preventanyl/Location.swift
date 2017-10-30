//
//  Location.swift
//  Preventanyl
//
//  Created by Brayden Traas on 2017-10-26.
//  Copyright © 2017 Yudhvir Raj. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class Location {

    static let LOCATION_CHANGED = "LOCATION_CHANGED"
    static let TRACK_ME_AT_ALL_TIMES = "trackMeAtAllTimes"
    static var currentLocation = CLLocation()
    
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate

    static func startLocationUpdatesAlways(caller: UIViewController?) {
        
        print("starting location updates always")
        
        appDelegate.locationManager.requestAlwaysAuthorization()

        appDelegate.locationManager.allowsBackgroundLocationUpdates = true;
        
        switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways:
                appDelegate.locationManager.startUpdatingLocation()
            break
            
            default:
                let message = "Background Location permissions required for reporting a traveling kit. Please allow in the settings app to continue."
                let alertController = UIAlertController(title: "Background Location Failed", message: message, preferredStyle: UIAlertControllerStyle.alert) //Replace UIAlertControllerStyle.Alert by
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    (result : UIAlertAction) -> Void in
                    print("OK")
                    
                    
                }
                
                //alertController.addAction(DestructiveAction)
                alertController.addAction(okAction)
                
                if let controller = caller {
                    DispatchQueue.main.async {
                        controller.present(alertController, animated: true, completion: nil)
                    }
                }
                break
            
        }
        
        appDelegate.locationManager.requestLocation()
        appDelegate.locationManager.startMonitoringSignificantLocationChanges()
        appDelegate.locationManager.startUpdatingLocation()
    }
    
    static func stopBackgroundUpdates() {
        print("stopBackgroundUpdates()")
        appDelegate.locationManager.stopUpdatingLocation()
        appDelegate.locationManager.stopMonitoringSignificantLocationChanges()
        appDelegate.locationManager.allowsBackgroundLocationUpdates = false;
    }
    
    static func startLocationUpdatesWhenInUse() {
        
        print("starting location updates when in use")
        
        appDelegate.locationManager.requestWhenInUseAuthorization()
        appDelegate.locationManager.requestLocation()
        //appDelegate.locationManager.startMonitoringSignificantLocationChanges()
        appDelegate.locationManager.startUpdatingLocation()
    }
    
    
    // decide what to do with the new location. Depends if this user has a moving Naloxone kit
    static func updateUser(location: CLLocation) {
        
        let date = Date()// Aug 25, 2017, 11:55 AM
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date) //11
        let minute = calendar.component(.minute, from: date) //55
        let sec = calendar.component(.second, from: date) //33
        let weekDay = calendar.component(.weekday, from: date) //6 (Friday)
        
        print("Time = \(weekDay) \(hour):\(minute):\(sec), Location = Lat:\(location.coordinate.latitude), Long:\(location.coordinate.longitude)")

        currentLocation = location
        Notifications.post(messageName: LOCATION_CHANGED, object: location, userInfo: nil)
        
    }
}
