//
//  FindApViewController+getJson.swift
//  DrawCircle
//
//  Created by Keiichiro Nagashima on 2014/08/05.
//  Copyright (c) 2014年 Keiichiro Nagashima. All rights reserved.
//

import Foundation

extension FindApViewController {
    
    func getApJson() -> Void {
        let manager :AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        
        var key: String!
        var name: String!
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
                self.clearText()
                return self.showAlert("検索結果", message:"入力されたデータのAPは見つかりませんでした")
            }
            self.makeCircles()
        }
        
        let requestFailure = {
            (operation :AFHTTPRequestOperation!, error :NSError!) -> Void in
            SVProgressHUD.dismiss()
            NSLog("requestFailure: \(error)")
            
            self.clearText()
            return self.showAlert("エラー", message:"サーバエラー\n管理者にお問い合わせ下さい\n\n(\(error))")
        }
        
        SVProgressHUD.show()
        manager.GET(url, parameters: parameters, success: requestSuccess, failure: requestFailure)
    }
}
