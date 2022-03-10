//
//  UserDefaultsManager.swift
//   AppsMaven
//
//  Created by Sandip Gill on 16/12/20.
//

import UIKit

class UserDefaultsManager: NSObject {

    static let shared = UserDefaultsManager()
    
    //Save login status
    var isLoggedIn : Bool {
        get{
            return UserDefaults.standard.bool(forKey: Keys.isLoggedIn)
        }
        set{
            UserDefaults.standard.set(newValue,forKey: Keys.isLoggedIn)
        }
    }
    
    //Save UserId
    var userId : String {
        get {
            return UserDefaults.standard.value(forKey: Keys.userId) as? String ?? ""
        }
        set{
            UserDefaults.standard.set(newValue,forKey: Keys.userId)
        }
    }

}
