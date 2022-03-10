//
//  AlertViewManager.swift
//   AppsMaven
//
//  Created by Sandip Gill on 16/12/20.
//

import Foundation
import UIKit

enum AlertButtonType:String {
    case Photos = "PHOTOS"
    case Camera = "CAMERA"
    case Yes = "YES"
    case No = "NO"
    case Cancel = "CANCEL"
    case Okay = "OK"
}

class AlertViewManager: NSObject {
    
    /// This function show alert on current screen with dynamic functions
    static func showAlert(title: String? = nil, message: String, alertButtonTypes: [AlertButtonType]? = [.Okay],   alertStyle: UIAlertController.Style? = nil, completion: ((AlertButtonType) -> () )? = nil ) {
        
        let style:UIAlertController.Style = alertStyle ?? .alert
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle:style)
        
        for actionTitle in alertButtonTypes!{
            alertController.addAction(UIAlertAction(title: actionTitle.rawValue, style: .default, handler:    {(alert :UIAlertAction!) in
                completion?(AlertButtonType(rawValue:alert.title!)!)
            }))
        }
        DispatchQueue.main.async {
            let controller = AppManager.shared.getPresentedViewController()
            controller?.present(alertController, animated: true, completion: nil)
        }
    }
}
