//
//  MenuHeaderTableViewCell.swift
//  Lifium
//
//  Created by Rajinder Kahlon on 02/03/22.
//

import UIKit
import SDWebImage

class MenuHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var userPhoneNumberLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var editProfilePicButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(){
        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.width/2
        if UserStore.shared.user?.profilePic != nil{
            self.userProfileImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.userProfileImageView.sd_setImage(with: URL(string: UserStore.shared.user?.profilePic ?? ""),placeholderImage:R.image.ic_profile())
        }else{
            userProfileImageView.image = R.image.ic_profile()
        }
        greetingLabel.text = String(format: "Hello, %@", UserStore.shared.user?.firstName ?? "")
        userEmailLabel.text = UserStore.shared.user?.email
        userPhoneNumberLabel.text = UserStore.shared.user?.phoneNumber
    }
    
}
