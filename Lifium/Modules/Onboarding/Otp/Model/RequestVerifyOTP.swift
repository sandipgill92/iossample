//
//  RequestVerifyOTP.swift
//  Lifium
//
//  Created by Hakikat Singh on 27/02/22.
//

import Foundation

struct RequestVerifyOTP{
    
    var phoneNumber,otp : String?
    
    var parameters : [String:Any]{
        var dictionary : [String:Any] = [:]
        dictionary["phoneNumber"] = phoneNumber
        dictionary["otp"] = otp
        return dictionary
    }
}
