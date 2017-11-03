	//
//  MainTabBarViewController.swift
//  Preventanyl
//
//  Created by kenth on 2017-10-13.
//  Copyright © 2017 Yudhvir Raj. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController{
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self as? UITabBarControllerDelegate
        
        
        
        // Do any additional setup after loading the view.
    }


    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let selectedTabInt = item.title  {
            print(selectedTabInt)
//            if(selectedTabInt == "Profile") {
//
//                let defaults = UserDefaults.standard
//                let token = defaults.bool(forKey: "isLogin")
//
//                if(token == true) {
//                    let profileNavigationController = self.selectedViewController as? UINavigationController
//
//                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//
//                    let secondviewController = storyBoard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
//                    profileNavigationController?.setViewControllers([secondviewController as UIViewController], animated: true)
//                } else {
//                    let profileNavigationController = self.selectedViewController as? UINavigationController
//
//                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//
//                    let usermenuviewController = storyBoard.instantiateViewController(withIdentifier: "UserMenuViewController") as! UserMenuViewController
//                    profileNavigationController?.setViewControllers([usermenuviewController as UIViewController], animated: true)
//
//                }
            
 //s           }
        }
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
