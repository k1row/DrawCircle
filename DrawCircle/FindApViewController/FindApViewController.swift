//
//  FindApViewController.swift
//  DrawCircle
//
//  Created by Keiichiro Nagashima on 2014/08/04.
//  Copyright (c) 2014年 Keiichiro Nagashima. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FindApViewController: UIViewController {
                            
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

    @IBAction func btnClearPushed(sender: UIButton) {
        self.clearText()
    }

    func clearText() -> Void {
        self.textSSID.text = ""
        self.textBSSID.text = ""
    }
    
    func showAlert(title: String, message: String) -> Void {
        let alert = UIAlertView()
        alert.title = title
        alert.message = message
        alert.addButtonWithTitle("OK")
        alert.show()
    }
}
