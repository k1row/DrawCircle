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

class CurrentPositionViewController: UIViewController {
    
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
}
