//
//  UserStore.swift
//  Lifium
//
//  Created by Hakikat Singh on 27/02/22.
//

import Foundation


class UserStore : NSObject{
    
    static let shared = UserStore()
    
    private let deviceTokenKey = "deviceTokenKey"
    private let userKey = "userKey"
    private let isLoginKey = "isLoginKey"
    
    
    var deviceToken: String{
        get{
            return UserDefaults.standard.object(forKey: deviceTokenKey) as? String ?? ""
        }set{
            UserDefaults.standard.synchronize()
            UserDefaults.standard.setValue(newValue, forKey: deviceTokenKey)
        }
    }
    
    var user: ProfileModel?{
        get {
            var userData: ProfileModel?
            if let data = UserDefaults.standard.value(forKey: userKey) as? Data {
                userData = try? JSONDecoder().decode(ProfileModel.self, from: data)
            }
            UserDefaults.standard.synchronize()
            return userData
        }set{
            UserDefaults.standard.synchronize()
            return UserDefaults.standard.set(try? JSONEncoder().encode(newValue), forKey: userKey)
        }
    }
    
    var isLogin:Bool?{
        get{
            return UserDefaults.standard.bool(forKey: isLoginKey)
        }set{
            UserDefaults.standard.synchronize()
            UserDefaults.standard.setValue(newValue, forKey: isLoginKey)
        }
    }
}
