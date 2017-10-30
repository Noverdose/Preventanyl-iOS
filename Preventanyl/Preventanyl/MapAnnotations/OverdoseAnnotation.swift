//
//  OverdoseAnnotation.swift
//  Preventanyl
//
//  Created by Brayden Traas on 2017-10-29.
//  Copyright © 2017 Yudhvir Raj. All rights reserved.
//

import Foundation
import MapKit

class OverdoseAnnotation: MKPointAnnotation, PreventanylAnnotation {
    let identifier = "overdose-annotation"
    let color = UIColor.red
    let image = #imageLiteral(resourceName: "error-orange")
    let defaultTitle = "Overdose"
    
}
