//
//  ProfileModel.swift
//  Lifium
//
//  Created by Hakikat Singh on 28/02/22.
//

import Foundation

struct ProfileModel: Codable{
    
    let id : String?
    let firstName : String?
    let lastName : String?
    let profilePic : String?
    let email : String?
    let countryCode : String?
    let phoneNumber : String?
    let gender : String?
    let state : String?
    let city : String?
    let dob : String?
    let height : String?
    let weight : String?
    let bloodGroup : String?
    let intrest : [String]?
    let accessToken : String?
    let language : String?
    let occupation : String?
    let isProfileCompleted : Bool?
    let isMobileVerified : Bool?
    let isMailVerified : Bool?
    let avaliableCoin : Int?
    let unreadNotificationCount : Int?
    let referralCode : String?
    let profileCompletion : Int?
    let lifiumId : Int?
    let isNotificationEnable : Bool?
    let connectedApp : String?
    let level : String?
    let badgeUrl : String?
    let androidLatestVersion : Int?
    let forceUpdate : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case firstName = "firstName"
        case lastName = "lastName"
        case profilePic = "profilePic"
        case email = "email"
        case countryCode = "countryCode"
        case phoneNumber = "phoneNumber"
        case gender = "gender"
        case state = "state"
        case city = "city"
        case dob = "dob"
        case height = "height"
        case weight = "weight"
        case bloodGroup = "bloodGroup"
        case intrest = "intrest"
        case accessToken = "accessToken"
        case language = "language"
        case occupation = "occupation"
        case isProfileCompleted = "isProfileCompleted"
        case isMobileVerified = "isMobileVerified"
        case isMailVerified = "isMailVerified"
        case avaliableCoin = "avaliableCoin"
        case unreadNotificationCount = "unreadNotificationCount"
        case referralCode = "referralCode"
        case profileCompletion = "profileCompletion"
        case lifiumId = "lifiumId"
        case isNotificationEnable = "isNotificationEnable"
        case connectedApp = "connectedApp"
        case level = "level"
        case badgeUrl = "badgeUrl"
        case androidLatestVersion = "androidLatestVersion"
        case forceUpdate = "forceUpdate"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        profilePic = try values.decodeIfPresent(String.self, forKey: .profilePic)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        height = try values.decodeIfPresent(String.self, forKey: .height)
        weight = try values.decodeIfPresent(String.self, forKey: .weight)
        bloodGroup = try values.decodeIfPresent(String.self, forKey: .bloodGroup)
        intrest = try values.decodeIfPresent([String].self, forKey: .intrest)
        accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken)
        language = try values.decodeIfPresent(String.self, forKey: .language)
        occupation = try values.decodeIfPresent(String.self, forKey: .occupation)
        isProfileCompleted = try values.decodeIfPresent(Bool.self, forKey: .isProfileCompleted)
        isMobileVerified = try values.decodeIfPresent(Bool.self, forKey: .isMobileVerified)
        isMailVerified = try values.decodeIfPresent(Bool.self, forKey: .isMailVerified)
        avaliableCoin = try values.decodeIfPresent(Int.self, forKey: .avaliableCoin)
        unreadNotificationCount = try values.decodeIfPresent(Int.self, forKey: .unreadNotificationCount)
        referralCode = try values.decodeIfPresent(String.self, forKey: .referralCode)
        profileCompletion = try values.decodeIfPresent(Int.self, forKey: .profileCompletion)
        lifiumId = try values.decodeIfPresent(Int.self, forKey: .lifiumId)
        isNotificationEnable = try values.decodeIfPresent(Bool.self, forKey: .isNotificationEnable)
        connectedApp = try values.decodeIfPresent(String.self, forKey: .connectedApp)
        level = try values.decodeIfPresent(String.self, forKey: .level)
        badgeUrl = try values.decodeIfPresent(String.self, forKey: .badgeUrl)
        androidLatestVersion = try values.decodeIfPresent(Int.self, forKey: .androidLatestVersion)
        forceUpdate = try values.decodeIfPresent(Bool.self, forKey: .forceUpdate)
    }
}
