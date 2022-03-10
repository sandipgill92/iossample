//
//  MenuFooterTableViewCell.swift
//  Lifium
//
//  Created by Rajinder Kahlon on 02/03/22.
//

import UIKit

class MenuFooterTableViewCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.logoImageView.roundCorner(radius: self.logoImageView.frame.width/2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
