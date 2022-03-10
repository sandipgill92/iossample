//
//  SmallThemeButton.swift
//  Lifium
//
//  Created by Hakikat Singh on 07/03/22.
//

import UIKit

class SmallThemeButton: UIButton {

    required init?(coder aDecoder : NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton(){
        self.roundCorner(radius:14)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = R.font.dmSansBold(size: 12.0)
        self.backgroundColor = R.color.theme()
    }
}
