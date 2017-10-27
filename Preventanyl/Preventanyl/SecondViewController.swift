//
//  SecondViewController.swift
//  Preventanyl
//
//  Created by Yudhvir Raj on 2017-09-28.
//  Copyright © 2017 Noverdose. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static let MODE_REGISTER = 0
    static let MODE_LOGIN    = 1
    
    @IBOutlet var trackMeAlwaysButton: UIButton!
    @IBAction func trackMeAlwaysClick(_ sender: Any) {
        appDelegate.locationManager.requestAlwaysAuthorization()
    }
    
    @IBOutlet var trackMeAlwaysSwitch: UISwitch!
    
    @IBAction func trackSwitchClick(_ trackTest: UISwitch) {
        UserDefaults.standard.set(trackTest.isOn, forKey: Location.TRACK_ME_AT_ALL_TIMES)
        if(trackTest.isOn) {
            Location.startLocationUpdatesAlways(caller: self)
        } else {
            Location.stopBackgroundUpdates()
            Location.startLocationUpdatesWhenInUse()
        }
    }
    
    
    var currentMode: Int = MODE_REGISTER // = MODE_REGISTER
    
    @IBOutlet var registerLoginLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myColor : UIColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        
        
        username.layer.borderColor = myColor.cgColor
        
        self.username.delegate = self
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile.png")
        self.username.leftView = imageView
        
        self.password.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
        
        self.currentMode = SecondViewController.MODE_REGISTER
        
        
        if UserDefaults.standard.bool(forKey: Location.TRACK_ME_AT_ALL_TIMES) {
            trackMeAlwaysSwitch.setOn(true, animated: false)
        } else {
            trackMeAlwaysSwitch.setOn(false, animated: false)
        }
        
        
    }



    func notImplemented(actionName: String) {
        let messageString = actionName + " Not Yet Implemented!"
        
        let alertController = UIAlertController(title: "Login Failed", message:
            messageString, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func performLogin() {

        notImplemented(actionName: "login")
        
    }
    
    @IBAction func registerLoginChanged(_ segmentedControl: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex
        {
        case SecondViewController.MODE_REGISTER  :
            currentMode = SecondViewController.MODE_REGISTER
            registerLoginLabel.text = "Register"
        case SecondViewController.MODE_LOGIN     :
            currentMode = SecondViewController.MODE_LOGIN
            registerLoginLabel.text = "Login"
        default: notImplemented(actionName: "UnknownOption")
        }
        
    }
    
    @IBAction func editChanged(_ sender: UITextField) {
        print("editChanged")
    }
    @IBAction func valueChanged(_ sender: UITextField) {
        print("valueChanged")
    }
    
    @IBAction func next(_ sender: UITextField) {
    
        print("next")
        
        self.password.becomeFirstResponder()
        
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //textField code
        print("textFieldShouldReturn")
        
        textField.resignFirstResponder()  //if desired
        
        switch textField
        {
            case username   : password.becomeFirstResponder()
            case password   :
                textField.endEditing(true)
                performLogin()
            default         : textField.endEditing(true)
        }
        
        //self.password.becomeFirstResponder()
        return true
    }
    
    @IBOutlet var username: UITextField!
    
    @IBOutlet var password: UITextField!
    
    @IBAction func loginClick(_ sender: Any) {
        performLogin()
    }
    
}

