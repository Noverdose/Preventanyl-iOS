//
//  Raycast.swift
//  Preventanyl
//
//  Created by Stephen Cheng on 2017-11-03.
//  Copyright © 2017 Yudhvir Raj. All rights reserved.
//

import UIKit

class Raycast {

    /*
     * isInside checks to see if a point is inside a polygon using the ray casting algorithm.
     * point is the coordinate we are checking
     * polygon is an array of coordinates in a cycle (either cw or ccw works
     *
     * returns if the point is inside the polygon if the point is exactly on an edge then behaviour is UNDEFINED
     */
    static func isInside(point: Coordinates, polygon: [Coordinates]) -> Bool {
        let polyCorners = polygon.count
        var j = polyCorners - 1
        var oddNodes = false
        let x = point.lat, y = point.long
        for i in 0..<polyCorners {
            let pi = polygon[i]
            let pj = polygon[j]
            let polyXi = pi.lat
            let polyYi = pi.long
            let polyXj = pj.lat
            let polyYj = pj.long
            if ((polyYi < y && polyYj >= y
                    || polyYj < y && polyYi >= y)
                    && (polyXi <= x || polyXj <= x)) {
                if (polyXi + (y - polyYi) / (polyYj - polyYi) * (polyXj - polyXi) < x) {
                    oddNodes = !oddNodes
                }
            }
            j = i
        }
        return oddNodes
    }
    
}
