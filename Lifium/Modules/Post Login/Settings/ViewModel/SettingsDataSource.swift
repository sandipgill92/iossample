//
//  SettingsDataSource.swift
//  Lifium
//
//  Created by Sandip Gill on 07/03/22.
//

import UIKit

class SettingsDataSource<CELL : UITableViewCell,T> : NSObject, UITableViewDataSource , UITableViewDelegate{
    
    private var cellIdentifier : String!
    private var isSetting : Bool!
    var configureCell : (CELL,T?, Bool) -> () = {_,_ ,_ in }
    var didSelect: (CELL, _ id : Int)->() = {_,_  in}
    var items : [T]?
    var isExpand : [Bool]
    
    init(cellIdentifier : String, item : [T]?,configureCell : @escaping (CELL,T?, _ isExapandable : Bool) -> (), didSelect :@escaping(CELL ,_ id : Int)->(), isSetting : Bool) {
        self.configureCell = configureCell
        self.didSelect = didSelect
        self.items = item
        self.cellIdentifier = cellIdentifier
        self.isSetting = isSetting
        self.isExpand = Array(repeating: false, count: item?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count != nil ? items!.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CELL
        let item = self.items?[indexPath.row]
        self.configureCell(cell , item, self.isExpand[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CELL
        self.didSelect(cell, indexPath.row)
        self.isExpand[indexPath.row] = !self.isExpand[indexPath.row]
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
