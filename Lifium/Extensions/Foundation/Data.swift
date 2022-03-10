//
//  Data.swift
//  Lifium
//
//  Created by Hakikat Singh on 27/02/22.
//

import Foundation

extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}
