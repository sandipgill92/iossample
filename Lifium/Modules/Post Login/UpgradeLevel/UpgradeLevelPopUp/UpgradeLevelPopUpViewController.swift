//
//  UpgradeLevelPopUpViewController.swift
//  Lifium
//
//  Created by Sandip Gill on 10/03/22.
//

import UIKit

class UpgradeLevelPopUpViewController: BaseViewController {

    @IBOutlet weak var vwGreetings: UIView!
    @IBOutlet weak var lblGreetingMsg: UILabel!
    
    @IBOutlet weak var lblUpgradeConfirmationMsg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnYesAction(_ sender: UIButton) {
        vwGreetings.isHidden = false
    }
    

    @IBAction func didTapOnBackground(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
