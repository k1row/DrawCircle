//
//  CurrentPositionViewController+LocationManager.swift
//  DrawCircle
//
//  Created by Keiichiro Nagashima on 2014/08/05.
//  Copyright (c) 2014年 Keiichiro Nagashima. All rights reserved.
//

import Foundation
import CoreLocation

extension CurrentPositionViewController: CLLocationManagerDelegate {

    func initLocationManager() -> Void {
        
        self.lm = CLLocationManager()
        self.lm.delegate = self
        
        //self.lm.requestAlwaysAuthorization() // For iOS8
        
        self.lm.pausesLocationUpdatesAutomatically = false
        
        //位置情報の精度
        self.lm.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        //位置情報取得間隔(m)
        self.lm.distanceFilter = 10
    }
    
    // 位置情報取得成功時
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!){
        self.latitude = newLocation.coordinate.latitude
        self.longitude = newLocation.coordinate.longitude
        
        self.setCenter(self.latitude, longitude: self.longitude)
        self.labelLatitude.text = self.latitude.description
        self.labelLongitude.text = self.longitude.description
    }
    
    // 位置情報取得失敗時
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        NSLog("Error")
    }
}

