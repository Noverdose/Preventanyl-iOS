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
    
    func mapView (_ mapView: MKMapView!, viewFor annotation: MKAnnotation!) -> MKAnnotationView! {
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
                view.rightCalloutAccessoryView = UIButton.init(type: .detailDisclosure) as UIView
            }
            return view
        }
        
        
        if let annotation = annotation as? PreventanylAnnotation {
            //let identifier = "preventanyl-pin"
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotation.identifier)

            annotationView.image = annotation.image
            annotationView.tintColor = annotation.color
            annotationView.canShowCallout = true
            
        
            
            return annotationView
            

//            if let pointAnnotation = annotation as? OverdoseAnnotation {
//
//            }
//
//            if let pointAnnotation = annotation as? MKPointAnnotation {
//                let annotationView = MKAnnotationView(annotation: pointAnnotation, reuseIdentifier: "preventanyl-point-pin")
//
//                annotationView.tintColor = annotation.color
//                return annotationView
//            }
//
//            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "preventanyl-pin")
//            annotationView.tintColor = annotation.color
//            //annotationView.pinTintColor = annotation.color
//            return annotationView
            
//            if annotation.title! == "My Place" {
//
//                annotationView.pinTintColor = UIColor.green
//
//            } else {
//
            
            //}
    
            
        
        }
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//
//        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
//
//        if annotation.title! == "My Place" {
//
//            annotationView.pinTintColor = UIColor.green
//
//        } else {
//
//            annotationView.pinTintColor = UIColor.red
//        }
//
//
//        return annotationView

        return nil
    }
    
}
