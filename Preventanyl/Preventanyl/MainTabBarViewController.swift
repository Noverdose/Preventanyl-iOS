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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let selectedTabInt = item.title  {
            print(selectedTabInt)
            if(selectedTabInt == "test") {
                
                let defaults = UserDefaults.standard
                let token = defaults.bool(forKey: "isLogin")
                
                if(token) {
                    
                } else {
                    
                }
                
            }
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
