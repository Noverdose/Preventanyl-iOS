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
class UserMenuViewController: UITableViewController{
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if kits == nil  {
            return 0;
        }
        return kits.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "KitItemTableViewCell", for: indexPath) as? KitItemTableViewCell else {
            fatalError("The dequeued cell is not an instance of KitItemTableViewCell.")
        }
//        if let kit =  kits.last {
//            print("added one label")
//            cell.label.text = kit.displayName
//
//        }
        cell.label.text = kits?[indexPath.row].displayName
        return cell;
        
        
    }
    
    var ref: DatabaseReference!
    
    override func viewDidAppear(_ animated: Bool) {
            kits.removeAll()
            tableView.reloadData()
            getkits()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        kits  = [StaticKit]()
        
        ref = Database.database().reference()

        //print(Auth.auth().currentUser?.uid)
        
        //ref.child("statickits").childByAutoId().setValue(Coordinates(lat: 1,long: 22).get_Dict_upload())
        //ref.child("statickits").childByAutoId().setValue(Address(city: "c", country: "c",postalCode : "p",provincestate:"pp",streetAddress:"sa").get_Address_Dict_upload())
//        let a = Address(city: "c", country: "c",postalCode : "p",provincestate:"pp",streetAddress:"sa")
//
//        let c = Coordinates(lat: 1,long: 22)
//        let sta = StaticKit(address: a, comments: "com", coordinates: c, displayName: "dis", id: "id", phone: "phon", userId: "us")
//
//        ref.child("statickits").childByAutoId().setValue(sta.get_StaticKit_Dict_upload())
        

        // Do any additional setup after loading the view.
    }
    
    var kits:[StaticKit]!
    
    func getkits() {
        if let uid = Auth.auth().currentUser?.uid {
            let query = ref.child("statickits").queryOrdered(byChild: "userId").queryEqual(toValue: uid)
            //print(query)
            // Listen for new comments in the Firebase database
            query.observeSingleEvent(of: .value, with: { (snapshot) -> Void in
  
                for one in snapshot.children {
                    print("one")
                    print(one)
                    if let kit = StaticKit(From: one as! DataSnapshot) {
                        print("kit is not nil")
                        self.kits.append(kit)
                        
                        self.tableView.beginUpdates()
                        self.tableView.insertRows(at: [IndexPath(row: self.kits.count-1, section: 0)], with: UITableViewRowAnimation.none)
                        self.tableView.endUpdates()
                    }
                }
  
                //print("in add view")
                //print(self.kits)
//
            })
        }
    }
    
    @IBAction func logoff(_ sender: Any) {
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
