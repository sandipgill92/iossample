//
//  AppManager.swift
//   AppsMaven
//
//  Created by Sandip Gill on 16/12/20.
//


import UIKit
import CoreLocation
class AppManager: NSObject {
    
    static let shared = AppManager()
    let locationManager = CLLocationManager()
    var locationUpdate:((_ latitude : Double,_ longitude : Double,_ locationName : String)->())?
    
    /// This function will get presented ViewController
    func getPresentedViewController()->UIViewController?{
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
    /// This methods used to parse data to a codable model
    /// - Parameters:
    ///   - modelType: This is any data model to parse json
    ///   - data: data is API response data
    /// - Returns: It will return parsed data as model
    func decode<T:Codable>(modelType: T.Type, data : Data) -> T {
        let model = try! JSONDecoder().decode(modelType, from: data)
        return model
    }
}
