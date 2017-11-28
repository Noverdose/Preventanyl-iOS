//
//  Overdose.swift
//  Preventanyl
//
//  Created by Brayden Traas on 2017-11-28.
//  Copyright © 2017 Yudhvir Raj. All rights reserved.
//

import Foundation
import MapKit

class Overdose {
    
    var region : String
    var reportedTime : Date
    var coordinates : CLLocationCoordinate2D
    
    init(region: String, reportedTime: Date, coordinates: CLLocationCoordinate2D) {
        self.region = region
        self.reportedTime = reportedTime
        self.coordinates = coordinates
    }
    
}
