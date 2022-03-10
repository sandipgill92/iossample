//
//  UIView.swift
//  Lifium
//
//  Created by Hakikat Singh on 24/02/22.
//

import UIKit

extension UIView{
    
    //MARK:- ROUND CORNERS
    func roundCorner(radius : CGFloat){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func addBorder(color : UIColor, width : CGFloat){
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}
