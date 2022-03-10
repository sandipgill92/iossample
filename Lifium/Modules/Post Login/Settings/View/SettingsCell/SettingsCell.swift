//
//  SettingsCell.swift
//  Lifium
//
//  Created by Sandip Gill on 07/03/22.
//

import UIKit
import SVProgressHUD

class SettingsCell: UITableViewCell {
    
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var bottomViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var settingsSwitch: UISwitch!
    @IBOutlet weak var settingName: UILabel!
    @IBOutlet weak var settingIcon: UIImageView!
    
    var viewModel : SettingsViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bottomView.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(icon : UIImage, title: String, isExpand : Bool){
        self.settingIcon.image = icon
        self.settingName.text = title
        
        if title == "Manage notifications"{
            self.settingsSwitch.isHidden = false
            self.settingsSwitch.isOn = UserStore.shared.user?.isNotificationEnable ?? false
        }else{
            self.settingsSwitch.isHidden = true
        }
        
        
        if title == "Contact Us"{
            self.bottomView.isHidden = !isExpand
            arrowImageView.image = isExpand ? R.image.ic_arrow_up() : R.image.ic_arrow_down()
        }else{
            self.bottomView.isHidden = true
            self.arrowImageView.isHidden = true
        }
        
    }
    
    //MARK:- BUTTON ACTIONS
    @IBAction func switchAction(_ sender: UISwitch) {
        self.viewModel = SettingsViewModel()
        self.viewModel.setNotificationStatus(sender.isOn ? "1" : "0") { status, error in
            DispatchQueue.main.async {
                if error != nil && status == false{
                    SVProgressHUD.showError(withStatus: error)
                }else{
                    self.settingsSwitch.isOn = status ?? false
                }
            }
        }
    }
}
