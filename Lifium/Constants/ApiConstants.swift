//
//  ApiConstants.swift
//  Lifium
//
//  Created by Hakikat Singh on 27/02/22.
//

import Foundation


//MARK:- API BASE URL
struct ApiBaseUrl{
    
    static let url = "http://13.234.34.50:3000/api/v1/"
}

struct ApiConstants{
    
    static let shared = ApiConstants()
    
    //MARK:- USER APIs
    let getOTP = "\(ApiBaseUrl.url)user/sendOtp"
    let verifyOTP = "\(ApiBaseUrl.url)user/verifyOtp"
    let createProfile = "\(ApiBaseUrl.url)user/createProfile"
    let getUserLevel = "\(ApiBaseUrl.url)user/level"
    let upgradeLevel = "\(ApiBaseUrl.url)user/level/"
    let updateNotificationStatus = "\(ApiBaseUrl.url)user/notification/"
    let referAndEarnImageUrl = "https://lifium-d.s3.ap-south-1.amazonaws.com/assets/lifium-coins.png"
    let referAndEarnWebUrl = "https://lifium.in/lifium-coins"
    let termConditionsUrl = "https://lifium.in/term-condition"
    let privacyPolicyUrl = "https://lifium.in/privacy-policy"
    let aboutUsUrl = "https://lifium.in/about-us"
    
}
