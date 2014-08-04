//
//  Circle.swift
//  drawCircles
//
//  Created by Keiichiro Nagashima on 2014/08/04.
//  Copyright (c) 2014年 Keiichiro Nagashima. All rights reserved.
//

import Foundation
import CoreLocation

class Circle : NSObject {

    var location: CLLocationCoordinate2D!
    var radius: Double!
    
    init(lat: Double, lon: Double, rad: Double) {
        self.location = CLLocationCoordinate2DMake(lat, lon)
        self.radius = rad
    }
    init(loc: CLLocationCoordinate2D, rad: Double) {
        self.location = loc
        self.radius = rad
    }
}