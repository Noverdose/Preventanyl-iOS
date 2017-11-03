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
import SHSPhoneComponent

class PhoneLoginViewController: UIViewController, UITextFieldDelegate {
    
    //loading icon
    
    let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    
    @IBOutlet var phone: SHSPhoneTextField!
    
    //the button below the textfields
    @IBOutlet weak var registerLoginButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loading icon
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        
        
        let myColor : UIColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        
        
        phone.layer.borderColor = myColor.cgColor
        phone.layer.borderWidth = 1
        phone.keyboardType = .phonePad
        
        
        
        
        self.phone.delegate = self
        
        phone.formatter.setDefaultOutputPattern("###-###-####")
        phone.formatter.prefix = "+1 "
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile.png")
        self.phone.leftView = imageView

        
        
    }
    
    
    
    func AlertError(errName: String) {
        let messageString = errName
        
        let alertController = UIAlertController(title: "Login Failed", message:
            messageString, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //textField code
        print("textFieldShouldReturn")
        
        textField.resignFirstResponder()  //if desired
        
        switch textField
        {

        case phone   :
            textField.endEditing(true)
            performSendCode()
        default         : textField.endEditing(true)
        }
        
        //self.password.becomeFirstResponder()
        return true
    }
    
    func performSendCode() {
        if let phoneNumber = phone.text {
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
                if let error = error {
                    print(error.localizedDescription)
                    self.AlertError(errName: error.localizedDescription)
                    return
                }
                // Sign in using the verificationID and the code sent to the user
                
                
                //1. Create the alert controller.
                let alert = UIAlertController(title: "verification Code", message: "Enter Code to Sign in.", preferredStyle: .alert)
                
                //2. Add the text field. You can configure it however you need.
                alert.addTextField { (textField) in
                    textField.text = ""
                    textField.keyboardType = .numberPad
                }
                
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default,handler: nil))
                
                // 3. Grab the value from the text field, and print it when the user clicks OK.
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert, weak self] (_) in
                    if let verificationCode = alert?.textFields![0].text {
                        
                        let credential = PhoneAuthProvider.provider().credential(
                            withVerificationID: verificationID!,
                            verificationCode: verificationCode)
                        Auth.auth().signIn(with: credential) { (user, error) in
                            if let error = error {
                                print(error)
                                self?.AlertError(errName: error.localizedDescription)
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
            print("SendCode")
            
        }
        
    }
    @IBAction func SendCodeClick(_ sender: UIButton) {
        //performLogin()
        performSendCode()

        
        
        
    }
    
}

