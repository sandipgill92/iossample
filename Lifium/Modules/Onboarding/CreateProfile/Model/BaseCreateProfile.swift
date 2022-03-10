//
//  BaseCreateProfile.swift
//  Lifium
//
//  Created by Hakikat Singh on 28/02/22.
//

import Foundation

struct BaseCreateProfile: Codable{
    
    let status : String?
    let message : String?
    let code : Int?
    let profileData : ProfileModel?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case message = "message"
        case code = "code"
        case profileData = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        profileData = try values.decodeIfPresent(ProfileModel.self, forKey: .profileData)
    }
    
}
