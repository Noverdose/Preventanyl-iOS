//
//  AbstractAnnotation.swift
//  Preventanyl
//
//  Created by Brayden Traas on 2017-10-29.
//  Copyright © 2017 Yudhvir Raj. All rights reserved.
//

import Foundation
import MapKit

protocol PreventanylAnnotation: MKAnnotation {
    var identifier: String { get }
    var color: UIColor { get }
    var image: UIImage { get }
    
    var defaultTitle: String { get }
    
    //var view: MKAnnotationView { get }
}
