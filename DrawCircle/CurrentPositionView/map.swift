//
//  CurrentPositionViewController+map.swift
//  DrawCircle
//
//  Created by Keiichiro Nagashima on 2014/08/05.
//  Copyright (c) 2014年 Keiichiro Nagashima. All rights reserved.
//

import Foundation
import MapKit

extension CurrentPositionViewController: MKMapViewDelegate {
    
    func initMap() -> Void {
        self.mapView.delegate = self
        self.mapView.showsBuildings = true
        self.mapView.showsPointsOfInterest = true
        self.mapView.showsUserLocation = true
    }
    
    func setCenter(latitude: Double, longitude: Double) -> Void {
        self.center = CLLocationCoordinate2DMake(latitude, longitude)
        self.mapView.region = MKCoordinateRegionMakeWithDistance(self.center, 100, 100)
        println(NSString(format: "map region is (%f, %f).", self.center.latitude, self.center.longitude))
    }

}
