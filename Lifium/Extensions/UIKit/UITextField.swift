//
//  UITextField.swift
//  Lifium
//
//  Created by Hakikat Singh on 28/02/22.
//

import UIKit

extension UITextField{
    
    //MARK: Check for empty textfield
    var isEmpty: Bool {
        if let text = self.text, !text.isEmpty {
            return false
        }
        return true
    }
    
    //MARK: Email validation variable
    var isValidEmail: Bool {
        let emailRegEx =
        "[a-zA-Z0-9._-]+@[a-z]+\\.{1}+[a-z]+"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: text)
    }
}
