//
//  CustomNavigationBar.swift
//  Lifium
//
//  Created by Hakikat Singh on 27/02/22.
//

import UIKit

class CustomNavigationBar: UIView {

    @IBOutlet weak var centreLabel: UILabel!
    @IBOutlet weak var leftTitleLabel: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    var delegate : CustomNavBarProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViews()
    }
    
    public func initViews() {
        Bundle.main.loadNibNamed(R.nib.customNavigationBar.name, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        self.backButton.touchUpInsideBlock {
            self.delegate.backButtonAction(self.backButton)
        }
        self.leftTitleLabel.isHidden = true
    }
    
    public func showOnlyTitle(isLeftTitle : Bool, isCenterTitle:Bool, title : ScreenName){
        self.leftTitleLabel.isHidden = !isLeftTitle
        self.leftTitleLabel.text = title.rawValue
        self.backButton.isHidden = isLeftTitle
        self.centreLabel.isHidden = !isCenterTitle
        self.centreLabel.text = title.rawValue
    }
    
}
