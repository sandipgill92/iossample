//
//  WebViewController.swift
//  Lifium
//
//  Created by Sandip Gill on 07/03/22.
//

import UIKit
import WebKit
import SVProgressHUD

class WebViewController: BaseViewController {
    
    class func control(url: String, screenName : ScreenName)-> WebViewController{
        let control = self.homeControl as! WebViewController
        control.url = url
        control.screenName = screenName
        return control
    }
    
    @IBOutlet weak var webView: WKWebView!
    
    var url : String!
    var screenName : ScreenName!
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customNavigationView.showOnlyTitle(isLeftTitle: false, isCenterTitle: true, title: screenName)
        let requestUrl = URL(string: url)
        self.webView.load(URLRequest(url: requestUrl!))
        self.webView.navigationDelegate = self
    }
    
}


extension WebViewController: WKNavigationDelegate{
    
    
    //MARK:- WEB VIEW DELEGATES
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.show()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
        SVProgressHUD.showError(withStatus: error.localizedDescription)
    }
}
