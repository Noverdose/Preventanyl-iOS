//
//  AccountUINavigaionController.swift
//  Preventanyl
//
//  Created by kenth on 2017-10-13.
//  Copyright © 2017 Yudhvir Raj. All rights reserved.
//

import UIKit

class AccountUINavigaionController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(!Userinfo.issetLogin()){
            Userinfo.registerislogin()
        }
        
        let islog = Userinfo.islogin
        
        if(islog) {
            performSegue(withIdentifier: "UserMenuSegue", sender: self)
        } else{
            performSegue(withIdentifier: "RegisterSegue", sender: self)
        }

        // Do any additional setup after loading the view.
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
