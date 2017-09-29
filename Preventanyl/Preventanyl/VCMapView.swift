//
//  VCMapView.swift
//  Preventanyl
//
//  Created by Yudhvir Raj on 2017-09-29.
//  Copyright © 2017 Yudhvir Raj. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension FirstViewController: MKMapViewDelegate {
    
    func mapView (mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if let annotation = annotation as? Marker {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint (x: -5, y: -5)
                view.rightCalloutAccessoryView = UIButton.init(type: .detailDisclosure) as! UIView
            }
            return view
        }
        return nil
    }
    
}
