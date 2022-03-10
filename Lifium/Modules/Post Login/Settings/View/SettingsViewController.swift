//
//  SettingsViewController.swift
//  Lifium
//
//  Created by Hakikat Singh on 07/03/22.
//

import UIKit
import SVProgressHUD

class SettingsViewController: BaseViewController {
    
    class func control (isSettingScreen : Bool) -> SettingsViewController{
        let control = self.homeControl as! SettingsViewController
        control.isSettings = isSettingScreen
        return control
    }
    
    @IBOutlet weak var settingsTableView: UITableView!
    
    var dataSource : SettingsDataSource<SettingsCell, SideMenuModel>!
    let settingsData = [SideMenuModel.init(icon: R.image.ic_bell()!, title: "Manage notifications"), SideMenuModel.init(icon: R.image.ic_connected()!, title: "Connected apps")]
    let aboutData = [SideMenuModel.init(icon: R.image.ic_about()!, title: "About Us"), SideMenuModel.init(icon: R.image.ic_privacy_lock()!, title: "Privacy Policy"),SideMenuModel.init(icon: R.image.ic_terms()!, title: "Terms & Conditions"),SideMenuModel.init(icon: R.image.ic_help()!, title: "Contact Us")]
    var isSettings : Bool = true
    var feedbackManager: FeedbackManager?
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customNavigationView.showOnlyTitle(isLeftTitle: false, isCenterTitle: true, title: isSettings ? .settings : .about)
        self.settingsTableView.register(UINib(nibName: R.nib.settingsCell.name, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.settingsCell.identifier)
        self.loadTableView()
    }
    
    func sendMail(_ sender : UIButton){
        let feedback = Feedback(recipients: sender.titleLabel?.text ?? "", subject: "Query from \(UserStore.shared.user?.firstName ?? "")")
          if let feedManager = FeedbackManager(feedback: feedback) {
              self.feedbackManager = feedManager
              self.feedbackManager?.send(on: self) { [weak self] result in
                  switch result {
                  case .failure(let error):
                      SVProgressHUD.showError(withStatus: error.localizedDescription)
                  self?.feedbackManager = nil
                  default:
                      return
                  }
              }
          }else{
              SVProgressHUD.showError(withStatus: SettingStrings.shared.mailError)
          }
        
    }
    
    func loadTableView(){
        self.dataSource = SettingsDataSource(cellIdentifier: R.nib.settingsCell.identifier, item: isSettings ? settingsData : aboutData, configureCell: { cell, data, isExpand in
            cell.configureCell(icon: data!.icon, title: data!.title, isExpand: isExpand)
            cell.helpButton.touchUpInsideBlock {
                self.sendMail(cell.helpButton)
            }
        }, didSelect: { cell,id  in
            //about us
            if self.isSettings == false{
                switch id {
                case 0:
                    self.navigationController?.pushViewController(WebViewController.control(url: ApiConstants.shared.aboutUsUrl, screenName: .aboutUS), animated: true)
                    return
                case 1:
                    self.navigationController?.pushViewController(WebViewController.control(url: ApiConstants.shared.privacyPolicyUrl, screenName: .privacy), animated: true)
                    return
                case 2:
                    self.navigationController?.pushViewController(WebViewController.control(url: ApiConstants.shared.termConditionsUrl, screenName: .terms), animated: true)
                    return
                case 3:
                    return
                default:
                    return
                }
            }
        }, isSetting: self.isSettings)
        DispatchQueue.main.async {
            self.settingsTableView.dataSource = self.dataSource
            self.settingsTableView.delegate = self.dataSource
            self.settingsTableView.reloadData()
        }
    }
}
