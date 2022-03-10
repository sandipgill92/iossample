//
//  UpgradeLevelDataSource.swift
//  Lifium
//
//  Created by Hakikat Singh on 07/03/22.
//

import UIKit

class UpgradeLevelDataSource<CELL : UITableViewCell,T> : NSObject, UITableViewDataSource , UITableViewDelegate{
    
    private var cellIdentifier : String!
    var configureCell : (CELL,T?, Bool) -> () = {_,_, _ in }
    var didSelect: (_ id : String, _ levelData : LevelData?)->() = {_, _ in}
    var items : [T]?
    var isExpandArray : [Bool]
    var didTappedUpgradeBtn : ()->() = {}
    
    init(cellIdentifier : String ,item : [T]?,configureCell : @escaping (CELL,T?,_ isExpandable: Bool) -> (), didSelect :@escaping(_ id : String, _ levelData : LevelData?)->(), didTapUpgrade :@escaping()->()) {
        self.cellIdentifier = cellIdentifier
        self.configureCell = configureCell
        self.didSelect = didSelect
        self.items = item
        self.didTappedUpgradeBtn = didTapUpgrade
        self.isExpandArray = Array(repeating: false, count: item?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count != nil ? items!.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CELL
        let item = self.items?[indexPath.row]
        self.configureCell(cell, item, isExpandArray[indexPath.row] )
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let vw = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 88))
        let btn = UIButton(frame: CGRect(x: 16, y: 16, width: tableView.frame.width - 32, height: 56))
        btn.setTitle("Upgrade", for: .normal)
        btn.titleLabel?.font = R.font.dmSansBold(size: 18.0)
        btn.titleLabel?.textColor = .white
        btn.backgroundColor = R.color.theme()
        btn.setBackgroundImage(R.image.buttonBackground(), for: .normal)
        btn.layer.cornerRadius = 14.0
        vw.addSubview(btn)
        btn.addTarget(self, action: #selector(btnUpgradeTapped), for: .touchUpInside)
        return vw
    }
    
    @objc func btnUpgradeTapped() {
        self.didTappedUpgradeBtn()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var indexToReload = [IndexPath]()
        if let index = isExpandArray.firstIndex(where: {$0}) , index != indexPath.row {
            isExpandArray[index] = false
            indexToReload.append(IndexPath(row: index, section: 0))
        }
        isExpandArray[indexPath.row] = !isExpandArray[indexPath.row]
        indexToReload.append(indexPath)
        tableView.reloadRows(at: indexToReload, with: .automatic)
        
    }
}
