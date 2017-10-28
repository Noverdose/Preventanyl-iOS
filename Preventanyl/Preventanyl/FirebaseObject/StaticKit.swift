//
//  StaticKit.swift
//  Preventanyl
//
//  Created by kenth on 2017-10-28.
//  Copyright © 2017 Yudhvir Raj. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase




class StaticKit: NSObject {
    var address : Address
    var comments : String
    var coordinates : Coordinates
    var displayName : String
    var id : String
    var phone : String
    var userId : String
    
    //used when getting data from firebase
    init?(From snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String:Any] else { return nil }
        guard let adressObject = dict["address"] as? [String : String] else { return nil }
        guard let comments = dict["comments"]  as? String else { return nil }
        guard let coordinatesObject = dict["coordinates"] as? [String : Double] else { return nil }
        guard let displayName = dict["displayName"]  as? String else { return nil }
        guard let id = dict["id"]  as? String else { return nil }
        guard let phone = dict["phone"]  as? String else { return nil }
        guard let userId = dict["userId"]  as? String else { return nil }
    
        self.address  = Address(addressOJ: adressObject)
        self.coordinates = Coordinates(coorOJ: coordinatesObject)
        self.comments = comments
        self.displayName = displayName
        self.id = id
        self.phone = phone
        self.userId = userId
    }
    
    override var description: String {
        get {
            let str = " Address :\n \(address)\n  coordinates:\n \(coordinates)\n comments: \(comments)\n displayName : \(displayName)\n id: \(id)\n phone: \(phone)\n userId: \(userId)"
            return str
        }
    }
}

class Address :NSObject{
    var country : String
    var postalCode : String
    var provincestate : String
    var streetAddress : String
    
    init(addressOJ: [String:String]) {
        country = addressOJ["country"]!
        postalCode = addressOJ["postalCode"]!
        provincestate = addressOJ["provincestate"]!
        streetAddress = addressOJ["streetAddress"]!
    }
    
    override var description: String {
        return "country: \(country)\n postalCode: \(postalCode)\n provincestate:\(provincestate)\n streetAddress: \(streetAddress)"
    }
}

class Coordinates: NSObject {
    var lat:Double
    var long:Double
    
    init(coorOJ: [String: Double]) {
        lat = coorOJ["lat"]!
        long = coorOJ["long"]!
    }
    
    override var description: String {
        return "lat : \(lat)\n long: \(long)"
    }
}
