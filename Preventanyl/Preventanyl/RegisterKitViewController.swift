//
//  RegisterKitViewController.swift
//  Preventanyl
//
//  Created by Yudhvir Raj on 2017-11-03.
//  Copyright © 2017 Yudhvir Raj. All rights reserved.
//

import UIKit
import Eureka

// Extend FormViewController for Eureka to utilise eureka syntax
class RegisterKitViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
                let comments:String? = dict["CommentsRow"] as? String
                print (city)
                print (country)
                print (postalCode)
                print (province)
                print (address)
                print (displayName)
                print (phoneNumber)
                // Implement future code here to validate and connect to backend
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
