//
//  HomeViewController.swift
//  Lifium
//
//  Created by Rajinder Kahlon on 02/03/22.
//

import UIKit
import SideMenuSwift

class HomeViewController: BaseViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnMenuAction(_ sender: UIButton) {
        print("test")
        sideMenuController?.revealMenu()
    }
    

}
