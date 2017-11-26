//
//  AccountMenuViewController.swift
//  Preventanyl
//
//  Created by kenth on 2017-10-13.
//  Copyright © 2017 Yudhvir Raj. All rights reserved.
//

import UIKit
import Firebase

/*
 After login, In your apps, you can get the user's basic profile information from the FIRUser object. See Manage Users.
 links:
 https://firebase.google.com/docs/reference/ios/firebaseauth/api/reference/Classes/FIRUser
 https://firebase.google.com/docs/auth/ios/manage-users
 */
class UserMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logoff(_ sender: UIButton) {
        Userinfo.islogin = false
        //log off from firebase
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        //get the current navigation stack array
        let navControllerArr = [(storyboard?.instantiateViewController(withIdentifier: "LoginViewController"))!]
        //perform the view switch
        navigationController?.setViewControllers(navControllerArr, animated: true)
    }

}
