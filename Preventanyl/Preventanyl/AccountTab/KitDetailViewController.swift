//
//  KitDetailViewController.swift
//  Preventanyl
//
//  Created by kenth on 2017-11-26.
//  Copyright © 2017 Yudhvir Raj. All rights reserved.
//

import UIKit
import Firebase

import Foundation
import SystemConfiguration

class KitDetailViewController: UIViewController {
    
    var ref : DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = kit.displayName
        phonenumLabel.text = kit.phone
        cityLabel.text = kit.address.city
        countryLabel.text = kit.address.country
        PostCodeLabel.text = kit.address.postalCode
        provinceLabel.text = kit.address.provincestate
        streetLabel.text = kit.address.streetAddress
        commentLabel.text = kit.comments
        
        ref = Database.database().reference()
        
    }
    
    @IBAction func backtap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deletetap(_ sender: Any) {
        
        if(!isInternetAvailable()) {
            
            let alert = UIAlertController(title: "Error", message: "No internet found.", preferredStyle: UIAlertControllerStyle.alert)
            
            // Add okay action to alert, to return back to the form
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler:nil
                
            ))
            
            // Present the alert to the user
            self.present(alert, animated: true, completion: nil)
            return
            
        }
        
        
        
        let alert = UIAlertController(title: "Delete", message: "Are you sure to delete the kit?", preferredStyle: UIAlertControllerStyle.alert)
        
        // Add okay action to alert, to return back to the form
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.default, handler: {
            
                action in
            self.ref.child("statickits").child(self.kit.id).removeValue { error,ref  in
                if error != nil {
                    print("error \(String(describing: error))")
                }
            }
                
                self.navigationController?.popViewController(animated: true)
                
            }
        ))
        
        // Present the alert to the user
        self.present(alert, animated: true, completion: nil)
        
    }
    var kit : StaticKit!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UITextView!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var provinceLabel: UILabel!
    @IBOutlet weak var PostCodeLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var phonenumLabel: UILabel!
    
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
    



}
