//
//  ThemeButton.swift
//  Lifium
//
//  Created by Hakikat Singh on 24/02/22.
//

import UIKit

class ThemeButton: UIButton {

    required init?(coder aDecoder : NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton(){
        self.roundCorner(radius:14)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = R.font.dmSansBold(size: 18.0)
        self.setBackgroundImage(UIImage.init(named: R.image.buttonBackground.name), for: .normal)
        self.backgroundColor = R.color.theme()
    }
}
