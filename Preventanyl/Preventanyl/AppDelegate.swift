//
//  AppDelegate.swift
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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    let locationManager = CLLocationManager ()
    let center = UNUserNotificationCenter.current()

    private var startTime: Date? //An instance variable, will be used as a previous location time.

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        locationManager.delegate = self
        //locationManager.requestWhenInUseAuthorization()
        // application.registerUserNotificationSettings (UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil))
        // UIApplication.shared.cancelAllLocalNotifications ()
        
        // Override point for customization after application launch.
        // let center = UNUserNotificationCenter.current()
        UNUserNotificationCenter.current().delegate = self
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization.
            if((error != nil)) {
                print("Request authorization failed!")
            } else {
                print("Request authorization succeeded!")
                self.locationManager.requestLocation()
            }
        }
        return true
    }
    
    func userNotificationCenter(_: UNUserNotificationCenter, willPresent _: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.alert, .sound])
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        switch status
        {
        case .authorizedAlways:
            print("always is authorized")
            locationManager.requestLocation()
        case .authorizedWhenInUse:
            print("when in use")
            locationManager.requestLocation()
        case .denied:
            print("denied")
        case .notDetermined:
            print("not determined")
        case .restricted:
            print("restricted")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let loc = locations.last else { return }
        
        let time = loc.timestamp
        
        guard let startTime2 = startTime else {
            self.startTime = time // Saving time of first location, so we could use it to compare later with second location time.
            return //Returning from this function, as at this moment we don't have second location.
        }
        
        let elapsed = time.timeIntervalSince(startTime2) // Calculating time interval between first and second (previously saved) locations timestamps.
        
        if elapsed > 1 { //If time interval is more than 10 seconds
            print("Received location from device")
            Location.updateUser(location: loc) //user function which uploads user location or coordinate to server.
            
            startTime = time //Changing our timestamp of previous location to timestamp of location we already uploaded.
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("error: \(error.localizedDescription)")
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        print("applicationDidEnterBackground")
        
//        if UserDefaults.standard.bool(forKey: Location.TRACK_ME_AT_ALL_TIMES) {
//            Location.startLocationUpdatesAlways(caller: nil)
//        } else {
//            Location.startLocationUpdatesWhenInUse()
//        }
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
        print("applicationDidBecomeActive")
        
        self.locationManager.delegate = self
        if UserDefaults.standard.bool(forKey: Location.TRACK_ME_AT_ALL_TIMES) {
            Location.startLocationUpdatesAlways(caller: nil)
        } else {
            Location.startLocationUpdatesWhenInUse()
        }

    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

