//
//  Userinfo.swift
//  Preventanyl
//
//  Created by kenth on 2017-10-13.
//  Copyright © 2017 Yudhvir Raj. All rights reserved.
//

import Foundation

struct Userinfo {

    
    private static var defaults = UserDefaults.standard
    
    public static var islogin: Bool {
        set{
            defaults.set(newValue, forKey: "islogin")
            defaults.synchronize()
        } get {
            return defaults.bool(forKey: "islogin")
        }
    }
    
    static func issetLogin()-> Bool{
        return defaults.object(forKey: "islogin") != nil
    }
    
    static func registerislogin() {
        defaults.register(defaults: ["islogin" : false])
    }
    
    
}
