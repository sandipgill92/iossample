//
//  BaseViewController.swift
//  Lifium
//
//  Created by Hakikat Singh on 27/02/22.
//

import UIKit
import SVProgressHUD
import SideMenuSwift

class BaseViewController: UIViewController {

    @IBOutlet weak var customNavigationView : CustomNavigationBar!
    
    class var control: BaseViewController {
        return R.storyboard.main().instantiateViewController(withIdentifier: String(describing: self)) as! BaseViewController
    }
    
    class var homeControl: BaseViewController {
        return R.storyboard.postLogin().instantiateViewController(withIdentifier: String(describing: self)) as! BaseViewController
    }
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        if customNavigationView != nil{
            customNavigationView.delegate = self
        }
        self.configureHUD()
        self.configureSideMenu()
    }
    
    //MARK:- FUNCTIONS
    func configureHUD(){
        SVProgressHUD.setDefaultAnimationType(.native)
        SVProgressHUD.setDefaultMaskType(.black)
    }
    
    func configureSideMenu(){
        SideMenuController.preferences.basic.menuWidth = self.view.frame.width*0.7
        SideMenuController.preferences.basic.enablePanGesture = true
        SideMenuController.preferences.basic.position = .above
    }

}


extension BaseViewController: CustomNavBarProtocol{
    
    func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
