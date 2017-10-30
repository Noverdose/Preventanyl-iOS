//
//  SecondViewController.swift
//  Preventanyl
//
//  Created by Yudhvir Raj on 2017-09-28.
//  Copyright © 2017 Noverdose. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SecondViewController: UIViewController, UITextFieldDelegate {

    //loading icon

    let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)

    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static let MODE_REGISTER = 0
    static let MODE_LOGIN    = 1
    static let MODE_PHONE = 2
    
    @IBOutlet var trackMeAlwaysButton: UIButton!
    @IBAction func trackMeAlwaysClick(_ sender: Any) {
        appDelegate.locationManager.requestAlwaysAuthorization()
    }
    
    //the button below the textfields
    @IBOutlet weak var registerLoginButton: UIButton!
    
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

        //loading icon
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        
        
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
            
            //set the button text to register
            registerLoginButton.setTitle("Register", for: .normal)
            //show the password field
            password.isHidden = false
        case SecondViewController.MODE_LOGIN     :
            currentMode = SecondViewController.MODE_LOGIN
            registerLoginLabel.text = "Login"
            
            //set the button text to Login
            registerLoginButton.setTitle("Login", for: .normal)
            password.isHidden = false
            
        case SecondViewController.MODE_PHONE     :
            currentMode = SecondViewController.MODE_PHONE
            registerLoginLabel.text = "Phone Login"
            
            //set the button text to Login
            registerLoginButton.setTitle("Send Verification Code", for: .normal)
            //hide the password field
            password.isHidden = true
            
            
            
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
    
    @IBAction func loginClick(_ sender: UIButton) {
            //performLogin()
            if(currentMode == SecondViewController.MODE_PHONE) {
                if let phoneNumber = username.text {
                    PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
                        if let error = error {
                            print(error.localizedDescription)
                            return
                        }
                        // Sign in using the verificationID and the code sent to the user
                        
                        
                        //1. Create the alert controller.
                        let alert = UIAlertController(title: "verificationCode", message: "hello", preferredStyle: .alert)
                        
                        //2. Add the text field. You can configure it however you need.
                        alert.addTextField { (textField) in
                            textField.text = ""
                        }
                        
                        
                            
                        // 3. Grab the value from the text field, and print it when the user clicks OK.
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert, weak self] (_) in
                            if let verificationCode = alert?.textFields![0].text {
                                let credential = PhoneAuthProvider.provider().credential(
                                    withVerificationID: verificationID!,
                                    verificationCode: verificationCode)
                                Auth.auth().signIn(with: credential) { (user, error) in
                                    if let error = error {
                                        print(error)
                                        return
                                    }
                                    print("lllog")
                                    Userinfo.islogin = true
                                    Userinfo.authVerificationID = verificationID
                                    let navControllerArr = [(self?.storyboard?.instantiateViewController(withIdentifier: "UserMenuViewController"))!]
                                    self?.navigationController?.setViewControllers(navControllerArr, animated: true)
                                }

                            }
                        }))
                        
                        // 4. Present the alert.
                        self.present(alert, animated: true, completion: nil)
                        
                        
                }
                print("loginClick")
               
            }
        
        
        
        
    }
    
}

}
