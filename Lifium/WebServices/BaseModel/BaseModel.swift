//
//  BaseModel.swift
//  Lifium
//
//  Created by Hakikat Singh on 27/02/22.
//

import Foundation


struct BaseModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
        case status
    }
    
    var code: Int?
    var message: String?
    var status: String?
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try container.decodeIfPresent(String.self, forKey: .message)
        code = try container.decodeIfPresent(Int.self, forKey: .code)
        status = try container.decodeIfPresent(String.self, forKey: .status)
    }
    
}
