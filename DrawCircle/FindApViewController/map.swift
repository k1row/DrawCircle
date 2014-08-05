//
//  FindApViewController+map.swift
//  DrawCircle
//
//  Created by Keiichiro Nagashima on 2014/08/05.
//  Copyright (c) 2014年 Keiichiro Nagashima. All rights reserved.
//

import Foundation
import MapKit

extension FindApViewController: MKMapViewDelegate {

    func initMap() -> Void {
        let latitude: Double = 35.657867
        let longitude: Double = 139.698067
        self.center = CLLocationCoordinate2DMake(latitude, longitude)
        self.mapView.delegate = self
        self.mapView.showsBuildings = true
        self.mapView.showsPointsOfInterest = true
        self.mapView.showsUserLocation = false
        self.mapView.region = MKCoordinateRegionMakeWithDistance(self.center, 100, 100)
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if (overlay.isKindOfClass(MKCircle)) {
            let route: MKCircle = overlay as MKCircle
            let routeRenderer = MKCircleRenderer(circle: route)
            routeRenderer.lineWidth = 1.0
            routeRenderer.strokeColor = UIColor.redColor()
            routeRenderer.fillColor = UIColor.redColor()
            routeRenderer.alpha = 0.1
            return routeRenderer
        }
        return nil
    }

    func makeCircles() -> Void {
        var currentLatitude: Double!
        var currentLongitude: Double!
        var currentAccuracy: Double! = 200.0
        
        for item in items {
            let tempDictionary:NSDictionary = item as NSDictionary;
            println(tempDictionary)
            circles.append(Circle(lat: tempDictionary.objectForKey("latitude").doubleValue, lon: tempDictionary.objectForKey("longitude").doubleValue, rad: tempDictionary.objectForKey("accuracy").doubleValue))
            
            if(currentAccuracy > tempDictionary.objectForKey("accuracy").doubleValue) {
                currentLatitude = tempDictionary.objectForKey("latitude").doubleValue
                currentLongitude = tempDictionary.objectForKey("longitude").doubleValue
            }
        }
        
        for c in circles {
            let circle:MKCircle = MKCircle(centerCoordinate:c.location, radius:c.radius)
            self.mapView.addOverlay(circle)
        }
        
        self.setCenter(currentLatitude, longitude: currentLongitude)
    }
  
    func setCenter(latitude: Double, longitude: Double) -> Void {
        self.center = CLLocationCoordinate2DMake(latitude, longitude)
        self.mapView.region = MKCoordinateRegionMakeWithDistance(self.center, 100, 100)
    }
    
}
