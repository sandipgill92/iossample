//
//  UpgradeLevelTableViewCell.swift
//  Lifium
//
//  Created by Rajinder Kahlon on 03/03/22.
//

import UIKit
import SDWebImage

class UpgradeLevelTableViewCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var levelPriceView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var levelImageView: UIImageView!
    @IBOutlet weak var isActivateLabel: UILabel!
    @IBOutlet weak var profileLevelLabel: UILabel!
    @IBOutlet weak var instructionsLevel: UILabel!
    @IBOutlet weak var btnRadio: UIButton!
    @IBOutlet weak var btnExpand: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var bottomDetailView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isActivateLabel.isHidden = true
        self.isActivateLabel.roundCorner(radius: 5.0)
        self.levelPriceView.roundCorner(radius: 6.0)
        self.levelPriceView.addBorder(color: .lightGray, width: 0.5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(data : LevelData, isExpandable : Bool){
        self.isActivateLabel.isHidden = !(data.isActivited ?? false)
        self.levelPriceView.isHidden =  data.isActivited ?? true
        self.priceLabel.text = String(format: "%i", data.coins ?? 0)
        self.profileLevelLabel.text = data.name
        self.instructionsLevel.attributedText = data.benifits?.htmlToAttributedString  //isExpandable ? data.benifits?.htmlToAttributedString : NSAttributedString("")
        self.levelImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.levelImageView.sd_setImage(with: URL(string: data.image ?? ""),placeholderImage:nil)
        self.bottomDetailView.isHidden = !isExpandable
        
        if isExpandable{
            self.bottomView.addBorder(color: .lightGray, width: 0.5)
            self.bottomView.roundCorner(radius: 14.0)
            self.topView.addBorder(color: .lightGray, width: 0)
        }else{
            self.topView.addBorder(color: .lightGray, width: 0.5)
            self.topView.roundCorner(radius: 14.0)
            self.bottomView.addBorder(color: .lightGray, width: 0)
        }
    }
}
