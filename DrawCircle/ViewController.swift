//
//  ViewController.swift
//  DrawCircle
//
//  Created by Keiichiro Nagashima on 2014/08/04.
//  Copyright (c) 2014年 Keiichiro Nagashima. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Foundation

class ViewController: UIViewController, MKMapViewDelegate {
                            
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var textSSID: UITextField!
    @IBOutlet weak var textBSSID: UITextField!
    @IBOutlet weak var btnSearch: UIButton!

    var circles = Array<Circle>()
    var center: CLLocationCoordinate2D!

    var items:NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.initMap()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnSearchPushed(sender: UIButton) {
        if textSSID.text == "" && textBSSID.text == "" {
            return self.showAlert("エラー", message:"検索したいAPのSSIDかBSSIDを入力してください")
        }
        
        self.getApJson()
    }

    func getApJson() -> Void {
        let manager :AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
      
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        
        var key: String?
        var name: String?
        if(textSSID.text != "") {
            key = "ssid"
            name = textSSID.text
        }
        if(textBSSID.text != "") {
            // BSSID優先
            key = "bssid"
            name = textBSSID.text
        }
        
        let url :String = "http://localhost:3000/api/v1/ap"
        let parameters :Dictionary = [
            "key"  : key as String,
            "name" : name as String,
        ]
        
        let requestSuccess = {
            (operation :AFHTTPRequestOperation!, responseObject :AnyObject!) -> Void in
            SVProgressHUD.dismiss()
            //NSLog("requestSuccess \(responseObject)")
            self.items = responseObject as NSArray
            
            if(self.items.count == 0) {
                self.textSSID.text = ""
                self.textBSSID.text = ""
                
                return self.showAlert("検索結果", message:"入力されたデータのAPは見つかりませんでした")
            }
            self.makeCircles()
        }
        
        let requestFailure = {
            (operation :AFHTTPRequestOperation!, error :NSError!) -> Void in
            SVProgressHUD.dismiss()
            NSLog("requestFailure: \(error)")
            
            self.textSSID.text = ""
            self.textBSSID.text = ""
            return self.showAlert("エラー", message:"サーバエラー\n管理者にお問い合わせ下さい\n\n(\(error))")
        }
        
        SVProgressHUD.show()
        manager.GET(url, parameters: parameters, success: requestSuccess, failure: requestFailure)
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
    
    func initMap() -> Void {
        let latitude: Double = 35.657867
        let longitude: Double = 139.698067
        self.center = CLLocationCoordinate2DMake(latitude, longitude)
        self.mapView.delegate = self
        self.mapView.showsBuildings = true
        self.mapView.showsPointsOfInterest = true
        self.mapView.showsUserLocation = false
        self.mapView.region = MKCoordinateRegionMakeWithDistance(self.center, 200, 200)
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
    
    func setCenter(latitude: Double, longitude: Double) -> Void {
        self.center = CLLocationCoordinate2DMake(latitude, longitude)
        self.mapView.region = MKCoordinateRegionMakeWithDistance(self.center, 200, 200)
    }
    
    func showAlert(title: String, message: String) -> Void {
        let alert = UIAlertView()
        alert.title = title
        alert.message = message
        alert.addButtonWithTitle("OK")
        alert.show()
    }
}
