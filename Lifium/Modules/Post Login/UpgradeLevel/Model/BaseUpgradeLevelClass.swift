//
//  BaseUpgradeLevelClass.swift
//
//  Created by Hakikat Singh on 06/03/22
//  Copyright (c) . All rights reserved.
//

import Foundation

struct BaseUpgradeLevelClass: Codable {

  enum CodingKeys: String, CodingKey {
    case message
    case status
    case levelData = "data"
    case code
  }

  var message: String?
  var status: String?
  var levelData: [LevelData]?
  var code: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    status = try container.decodeIfPresent(String.self, forKey: .status)
    levelData = try container.decodeIfPresent([LevelData].self, forKey: .levelData)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
  }

}
