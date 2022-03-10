//
//  RequestCreateProfile.swift
//  Lifium
//
//  Created by Hakikat Singh on 28/02/22.
//

import Foundation

struct RequestCreateProfile{
    
    var firstName,lastName, email,referralCode  : String?
    
    var parameters : [String:Any]{
        var dictionary : [String:Any] = [:]
        dictionary["firstName"] = firstName
        dictionary["lastName"] = lastName
        dictionary["email"] = email
        dictionary["referralCode"] = ""
        return dictionary
    }
}
