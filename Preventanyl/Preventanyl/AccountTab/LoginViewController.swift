//
//  LoginViewController.swift
//  Preventanyl
//
//  Created by Yu Hong Huang on 2017-11-24.
//  Copyright © 2017 Yudhvir Raj. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate  {

    static let MODE_LOGIN    = 1
    
    //activity indicator
    var loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
    
    
    @IBOutlet var email: UITextField!
    
    @IBOutlet var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.email.delegate = self
        
        self.password.delegate = self
        
        
    }
    
    @IBAction func loginClick(_ sender: Any) {
        performLogin()
    }
    
    func notImplemented(actionName: String) {
        let messageString = actionName + " Not Yet Implemented!"
        
        let alertController = UIAlertController(title: "Login Failed", message:
            messageString, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func performLogin() {
        if let email = self.email.text, let password = self.password.text {
            loadingIndicator.startAnimating()

                // [START headless_email_auth]
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    // [START_EXCLUDE]
                    self.loadingIndicator.stopAnimating()
                    
                    if let error = error {
                        print(error.localizedDescription)
                        let alertController = UIAlertController(title: "Error", message:
                            error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                        
                        self.present(alertController, animated: true, completion: nil)
                        return
                    }
                    
                    print("lllog")
                    Userinfo.islogin = true
                    //Userinfo.authVerificationID = verificationID
                    let navControllerArr = [(self.storyboard?.instantiateViewController(withIdentifier: "UserMenuViewController"))!]
                    
                    self.navigationController?.setViewControllers(navControllerArr, animated: true)

                    // [END_EXCLUDE]
                }
                // [END headless_email_auth]
        } else {
            print("email/password can't be empty")
            let alertController = UIAlertController(title: "Error", message:
                "email/password can't be empty", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
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
        case email   : password.becomeFirstResponder()
        case password   :
            textField.endEditing(true)
            performLogin()
        default         : textField.endEditing(true)
        }
        
        //self.password.becomeFirstResponder()
        return true
    }
    
    


}
