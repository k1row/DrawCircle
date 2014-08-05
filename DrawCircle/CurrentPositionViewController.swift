//
//  CurrentPositionViewController.swift
//  DrawCircle
//
//  Created by Keiichiro Nagashima on 2014/08/05.
//  Copyright (c) 2014年 Keiichiro Nagashima. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CurrentPositionViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var labelLatitude: UILabel!
    @IBOutlet weak var labelLongitude: UILabel!
    
    var lm: CLLocationManager! = nil
    
    var longitude: CLLocationDegrees!
    var latitude: CLLocationDegrees!
    var center: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.initMap()
        self.initLocationManager()
        lm.startUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnStartPushed(sender: UIButton) {
        lm.startUpdatingLocation()
    }
    
    @IBAction func btnStopPushed(sender: UIButton) {
        self.labelLatitude.text = ""
        self.labelLongitude.text = ""
        lm.stopUpdatingLocation()
    }
    
    func initMap() -> Void {
        self.mapView.delegate = self
        self.mapView.showsBuildings = true
        self.mapView.showsPointsOfInterest = true
        self.mapView.showsUserLocation = true
    }
    
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
    
    func setCenter(latitude: Double, longitude: Double) -> Void {
        self.center = CLLocationCoordinate2DMake(latitude, longitude)
        self.mapView.region = MKCoordinateRegionMakeWithDistance(self.center, 100, 100)
        println(NSString(format: "map region is (%f, %f).", self.center.latitude, self.center.longitude))
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
