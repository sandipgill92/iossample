//
//  Actions.swift
//  Lifium
//
//  Created by Hakikat Singh on 06/03/22.
//

import UIKit
import SideMenuSwift

class ActionHome{
    
    class func execute(){
        DispatchQueue.main.async {
            let rootVC : SideMenuController =  R.storyboard.postLogin().instantiateViewController(withIdentifier: NavigationIdentifier.SideMenu.rawValue) as! SideMenuController
            let navController : UINavigationController = R.storyboard.postLogin().instantiateViewController(withIdentifier: NavigationIdentifier.HomeNavigationController.rawValue) as! UINavigationController
            navController.viewControllers = [rootVC]
            UIApplication.shared.keyWindow?.makeKeyAndVisible()
            UIApplication.shared.keyWindow?.rootViewController = navController
        }
    }
}
