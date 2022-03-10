//
//  LevelData.swift
//
//  Created by Hakikat Singh on 06/03/22
//  Copyright (c) . All rights reserved.
//

import Foundation

struct LevelData: Codable {

  enum CodingKeys: String, CodingKey {
    case isActivited
    case name
    case benifits
    case image
    case coins
  }

  var isActivited: Bool?
  var name: String?
  var benifits: String?
  var image: String?
  var coins: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    isActivited = try container.decodeIfPresent(Bool.self, forKey: .isActivited)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    benifits = try container.decodeIfPresent(String.self, forKey: .benifits)
    image = try container.decodeIfPresent(String.self, forKey: .image)
    coins = try container.decodeIfPresent(Int.self, forKey: .coins)
  }

}
