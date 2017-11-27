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
        guard let dict = snapshot.value as? [String:Any] else { print("dict is nil")
            return nil }
        guard let adressObject = dict["address"] as? [String : String] else {
            print("adressObject is nil")
            return nil }
        let comments = dict["comments"]  as? String ?? ""
        guard let coordinatesObject = dict["coordinates"] as? [String : Double] else {
            print("coordinatesObject is nil")
            return nil }
        guard let displayName = dict["displayName"]  as? String else {
            print("displayName is nil")
            return nil }
        guard let id = dict["id"]  as? String else {
            print("id is nil")
            return nil }
        guard let phone = dict["phone"]  as? String else {
            print("phone is nil")
            return nil }
        guard let userId = dict["userId"]  as? String else
        {
            print("userId is nil")
            return nil }
    
        self.address  = Address(addressOJ: adressObject)
        self.coordinates = Coordinates(coorOJ: coordinatesObject)
        self.comments = comments
        self.displayName = displayName
        self.id = id
        self.phone = phone
        self.userId = userId
    }
    
    init(address: Address,
         comments: String,
         coordinates:Coordinates,
         displayName:String,
         id:String,
         phone:String,
         userId:String) {
        self.address  = address
        self.coordinates = coordinates
        self.comments = comments
        self.displayName = displayName
        self.id = id
        self.phone = phone
        self.userId = userId
    }
    
    //function to get the Address of the dictinary type to insert into the firebase database as json
    func get_StaticKit_Dict_upload()-> Dictionary<String,Any> {
        let addressDict = self.address.get_Address_Dict_upload()
        let coorDict = coordinates.get_Coordinates_Dict_upload()
        
        
        
        let staticKit: [String:Any]  =
            [   "address" : addressDict["address"]!,
                "coordinates" : coorDict["coordinates"]!,
             "comments" : comments,
                "displayName": displayName,
                "id" : id,
                "phone" : phone,
                "userId" : userId
                ]
        return staticKit
        
    }
    
    override var description: String {
        get {
            let str = " Address :\n \(address)\n  coordinates:\n \(coordinates)\n comments: \(comments)\n displayName : \(displayName)\n id: \(id)\n phone: \(phone)\n userId: \(userId)"
            return str
        }
    }
}

class Address :NSObject{
    
    var streetAddress : String
    var city: String
    var provincestate : String
    var country : String
    var postalCode : String
    
    init(addressOJ: [String:String]) {
        streetAddress = addressOJ["streetAddress"]!
        city = addressOJ["city"]!
        provincestate = addressOJ["provincestate"]!
        country = addressOJ["country"]!
        postalCode = addressOJ["postalCode"]!
    }
    
    init(city: String, country: String,postalCode : String,provincestate:String,streetAddress:String) {
        self.streetAddress = streetAddress
        self.city = city
        self.provincestate = provincestate
        self.country = country
        self.postalCode = postalCode
    }
    
    //function to get the Address of the dictinary type to insert into the firebase database as json
    func get_Address_Dict_upload()-> Dictionary<String,Dictionary<String, String>> {
        let address =
            ["city" : city,
             "country" : country,
             "postalCode" : postalCode,
             "provincestate":provincestate,
             "streetAddress":streetAddress,
            ]
        let dict = ["address" : address]
        return dict
        
    }
    
    
    
    override var description: String {
        return "country: \(country)\n postalCode: \(postalCode)\n provincestate:\(provincestate)\n streetAddress: \(streetAddress)\n city: \(city)"
    }
}

class Coordinates: NSObject {
    var lat:Double
    var long:Double
    
    init(coorOJ: [String: Double]) {
        lat = coorOJ["lat"]!
        long = coorOJ["long"]!
    }
    
    init(lat: Double, long: Double) {
        self.lat = lat
        self.long = long
    }
    
    override var description: String {
        return "lat : \(lat)\n long: \(long)"
    }
    
    //function to get the coordinate of dictinary type to insert into the firebase database s
    func get_Coordinates_Dict_upload()-> Dictionary<String,Dictionary<String, Double>> {
        let coordinates = ["lat" : lat, "long" : long]
        let dict = ["coordinates" : coordinates]
        return dict
        
    }
}
