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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
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
            print("always")
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        print(locations)
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
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

