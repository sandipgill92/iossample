//
//  String.swift
//  Lifium
//
//  Created by Hakikat Singh on 27/02/22.
//

import Foundation

extension String {
    
    func chopPrefix(_ count: Int = 1) -> String {
        return substring(from: index(startIndex, offsetBy: count))
    }

    func chopSuffix(_ count: Int = 1) -> String {
        return substring(to: index(endIndex, offsetBy: -count))
    }
    
    var htmlToAttributedString: NSAttributedString? {
           guard let data = data(using: .utf8) else { return nil }
           do {
               return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
           } catch {
               return nil
           }
       }
       var htmlToString: String {
           return htmlToAttributedString?.string ?? ""
       }
}
