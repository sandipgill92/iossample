//
//  CustomTextField.swift
//  Lifium
//
//  Created by Hakikat Singh on 23/02/22.
//

import UIKit
import MaterialComponents

class CustomTextField: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var textField: MDCOutlinedTextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViews()
    }
    
    public func initViews() {
        Bundle.main.loadNibNamed(R.nib.customTextField.name, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        self.textField.verticalDensity = 0
        self.textField.setOutlineColor(.lightGray, for: .normal)
        self.textField.setNormalLabelColor(.lightGray, for: .normal)
        self.textField.setOutlineColor(UIColor(named: R.color.theme.name)!, for: .editing)
        self.textField.setFloatingLabelColor(UIColor(named: R.color.theme.name)!, for: .editing)
        self.textField.leadingAssistiveLabel.textColor = R.color.theme()
        self.textField.containerRadius = 14.0
        self.textField.leadingEdgePaddingOverride = 14.0
    }
    
    public func configureTextField(text : String, placeholder : String){
        self.textField.label.text = text
        self.textField.placeholder = placeholder
    }
}
