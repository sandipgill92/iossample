//
//  LifiumCoinViewController.swift
//  Lifium
//
//  Created by Hakikat Singh on 07/03/22.
//

import UIKit
import SDWebImage
import WebKit

class LifiumCoinViewController: BaseViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var coinImageView: UIImageView!
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customNavigationView.showOnlyTitle(isLeftTitle: false, isCenterTitle: true, title: .lifiumCoins)
        self.setupUI()
    }
    
    //MARK:- FUNCTIONS
    func setupUI(){
        self.webView.isHidden = true
        self.coinImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.coinImageView.sd_setImage(with: URL(string: ApiConstants.shared.referAndEarnImageUrl),placeholderImage:nil)
        
        let requestUrl = URL(string: ApiConstants.shared.referAndEarnWebUrl)
        self.webView.load(URLRequest(url: requestUrl!))
    }
    
    //MARK:- BUTTON ACTIONS
    @IBAction func referNowButton(_ sender: SmallThemeButton) {
        let items = ["Hi there, \(UserStore.shared.user?.firstName ?? "") invites you to join Lifium. Use \(UserStore.shared.user?.firstName ?? "")'s referral code: \(UserStore.shared.user?.referralCode ?? "") to get benefits.\n\nJoin now at https://lifium.page.link/Di9H"]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    @IBAction func detailsButton(_ sender: UIButton) {
        self.webView.isHidden = false
    }
}
