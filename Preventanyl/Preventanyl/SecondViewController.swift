//
//  SecondViewController.swift
//  Preventanyl
//
//  Created by Yudhvir Raj on 2017-09-28.
//  Copyright © 2017 Yudhvir Raj. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let myColor : UIColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        
        
        username.layer.borderColor = myColor.cgColor
        
        self.username.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        self.password.becomeFirstResponder()
        return true
    }
    
    @IBOutlet var username: UITextField!
    
    @IBOutlet var password: UITextField!
    
}

