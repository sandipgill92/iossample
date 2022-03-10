//
//  SideMenuModel.swift
//  Lifium
//
//  Created by Hakikat Singh on 06/03/22.
//

import UIKit

struct SideMenuModel {
    var icon: UIImage
    var title: String
}

extension SideMenuModel{
    static var menu: [SideMenuModel] = [
        SideMenuModel(icon: R.image.about()!, title: "Header"),
        SideMenuModel(icon: R.image.manageAccount()!, title: "Manage Account"),
        SideMenuModel(icon: R.image.upgradeLevel()!, title: "Upgrade Level"),
        SideMenuModel(icon: R.image.lifiumCoins()!, title: "Lifium Coins"),
        SideMenuModel(icon: R.image.orderHistory()!, title: "Order History"),
        SideMenuModel(icon: R.image.settings()!, title: "Settings"),
        SideMenuModel(icon: R.image.about()!, title: "About"),
        SideMenuModel(icon: R.image.about()!, title: "Footer")
    ]
}
