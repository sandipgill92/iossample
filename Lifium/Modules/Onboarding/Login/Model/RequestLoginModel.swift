//
//  RequestLoginModel.swift
//  Lifium
//
//  Created by Hakikat Singh on 27/02/22.
//

import Foundation

struct RequestLoginModel{
    
    var phoneNumber : String?
    
    var parameters : [String:Any]{
        var dictionary : [String:Any] = [:]
        dictionary["phoneNumber"] = phoneNumber
        dictionary["deviceToken"] = UserStore.shared.deviceToken
        dictionary["deviceType"] = "ios"
        return dictionary
    }
}
