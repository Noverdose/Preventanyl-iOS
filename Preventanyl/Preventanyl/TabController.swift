//
//  TabController.swift
//  Preventanyl
//
//  Created by Brayden Traas on 2017-10-26.
//  Copyright © 2017 Noverdose. All rights reserved.
//

import UIKit
import CoreLocation

class TabController: UITabBarController, CLLocationManagerDelegate {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //appDelegate.locationManager.startUpdatingLocation()
        

        // Do any additional setup after loading the view.
    }


//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        guard let loc = locations.last else { return }
//
//        let time = loc.timestamp
//
//        guard let startTime2 = startTime else {
//            self.startTime = time // Saving time of first location, so we could use it to compare later with second location time.
//            return //Returning from this function, as at this moment we don't have second location.
//        }
//
//        let elapsed = time.timeIntervalSince(startTime2) // Calculating time interval between first and second (previously saved) locations timestamps.
//
//        if elapsed > 1 { //If time interval is more than 10 seconds
//            print("Received location from device")
//            Location.updateUser(location: loc) //user function which uploads user location or coordinate to server.
//
//            startTime = time //Changing our timestamp of previous location to timestamp of location we already uploaded.
//
//        }
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
