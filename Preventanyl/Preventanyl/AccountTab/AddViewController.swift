//
//  AddViewController.swift
//  Preventanyl
//
//  Created by Yu Hong Huang on 2017-11-25.
//  Copyright © 2017 Yudhvir Raj. All rights reserved.
//

import UIKit
import Eureka
import Firebase

import Foundation
import SystemConfiguration

import CoreLocation

class AddViewController: FormViewController {


    @IBAction func backtapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    //func to check network connection
    func isInternetAvailable() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    

    @IBAction func savetapped(_ sender: UIBarButtonItem) {
        //
        if(isInternetAvailable()) {
            self.formSub()
        } else {
        
            let alert = UIAlertController(title: "Error", message: "No internet found.", preferredStyle: UIAlertControllerStyle.alert)
            
            // Add okay action to alert, to return back to the form
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
            
            // Present the alert to the user
            self.present(alert, animated: true, completion: nil)
        }
            
        
        
    }
    
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        // Make the form
        form
            // Make address section
            +++ Section("Address")
            // City Row
            <<< TextRow() {
                $0.tag = "CityRow"
                $0.title = "City"
                $0.placeholder = "Coventry"
            }
            // Country Row
            <<< TextRow() {
                $0.tag = "CountryRow"
                $0.title = "Country"
                $0.placeholder = "England"
            }
            // Postal Code Row
            <<< TextRow() {
                $0.tag = "PostalRow"
                $0.title = "Post Code"
                $0.placeholder = "ABC 123"
            }
            // Province Row
            <<< TextRow() {
                $0.tag = "ProvinceRow"
                $0.title = "Province"
                $0.placeholder = "BC"
            }
            // Address Row
            <<< TextRow() {
                $0.tag = "AddressRow"
                $0.title = "Street Address"
                $0.placeholder = "1234 Cool Avenue"
            }
            
            <<< LocationRow(){
                $0.tag = "CoordinatesRow"
                $0.title = "Pick the Location"
                $0.value = CLLocation(latitude: 49.2827, longitude: -123.1207)
            }
            
            
            // Display Information
            +++ Section("Display Information")
            <<< TextRow() {
                $0.tag = "DNameRow"
                $0.title = "Display Name"
                $0.placeholder = "Cool Club"
            }
            // Phone Number Rows
            <<< PhoneRow() {
                $0.tag = "PhoneRow"
                $0.title = "Phone Number"
                $0.placeholder = "604-123-4567"
            }
            // Comments Row
            <<< TextRow() {
                $0.tag = "CommentsRow"
                $0.title = "Additional Comments"
                $0.placeholder = "Floor 2, on the left"
            }
            // Submit Button Row
            // NOTE : Future implementation will be a submit button in top right as
            // this may be moved to be used with table view
            <<< ButtonRow() {
                $0.title = "Submit"
                $0.onCellSelection (self.submitNaloxeneKit)
        }
    }
    
    // Function called when submit button is pressed
    // To post to server
    func submitNaloxeneKit(cell: ButtonCellOf<String>, row: ButtonRow) {
        formSub()
        
    }
    
    func formSub() {
        print("tapped!")
        // Get all values in form as an array, including hidden
        let dict = form.values (includeHidden: true)
        
        // Only run code to post and validate if the value are not nil, except for comments
        if
            let city:String = dict["CityRow"] as? String,
            let country:String = dict["CountryRow"] as? String,
            let postalCode:String = dict["PostalRow"] as? String,
            let province:String = dict["ProvinceRow"] as? String,
            let address:String = dict["AddressRow"] as? String,
            let displayName:String = dict["DNameRow"] as? String,
            let phoneNumber:String = dict["PhoneRow"] as? String {
            // Get comments not in the if statement as it is not a required value
            let comments:String? = dict["CommentsRow"] as? String ?? ""
            let coordinates: CLLocation = dict["CoordinatesRow"] as! CLLocation
            print (city)
            print (country)
            print (postalCode)
            print (province)
            print (address)
            print (displayName)
            print (phoneNumber)
            print(coordinates.coordinate.latitude)
            print(coordinates.coordinate.longitude)
            // code to insert data to firebase database directly
            
            let latval = coordinates.coordinate.latitude
            let longval = coordinates.coordinate.longitude
            
            //get the autoid reference for the added kit
            let id = ref.child("statickits").childByAutoId()
            let idstring = id.key
            //if user id can be obtained
            if let uid = Auth.auth().currentUser?.uid {
                //coordinate to be implemented in the future
                let c = Coordinates(lat: latval,long: longval)
                //construct the address data to insert into firebase db
                let addressoj = Address(city: city, country: country, postalCode: postalCode, provincestate: province, streetAddress: address)
                //construct the static kit data; it is what will be added in firebase db
                let sta = StaticKit(address: addressoj, comments: comments ?? "", coordinates: c, displayName: displayName, id: idstring, phone: phoneNumber, userId: uid)
                
                //call the func for getting the dictionary object which can be converted to josn
                //in firebase.
                //insert this kit into db
                
                id.setValue(sta.get_StaticKit_Dict_upload())
                
                //finished
                navigationController?.popViewController(animated: true)
            }
            
            
            
        } else {
            // Alert the user that there are fields that have not been filled out
            // Create an alert to alert the user to check empty fields
            let alert = UIAlertController(title: "Please fill out the form", message: "Missing fields", preferredStyle: UIAlertControllerStyle.alert)
            
            // Add okay action to alert, to return back to the form
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
            
            // Present the alert to the user
            self.present(alert, animated: true, completion: nil)
        }
    }

    

}
