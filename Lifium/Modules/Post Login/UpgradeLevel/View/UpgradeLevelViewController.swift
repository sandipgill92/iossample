//
//  UpgradeLevelViewController.swift
//  Lifium
//
//  Created by Rajinder Kahlon on 03/03/22.
//

import UIKit

class UpgradeLevelViewController: BaseViewController {
    
    @IBOutlet weak var tblView: UITableView!
    
    var viewModel : UpgradeLevelViewModel!
    var dataSource : UpgradeLevelDataSource<UpgradeLevelTableViewCell,LevelData>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableCells()
        self.customNavigationView.showOnlyTitle(isLeftTitle: false, isCenterTitle: true, title: .upgradeLevel)
        self.getProfileLevel()
    }
    
    private func registerTableCells() {
        tblView.register(UINib(nibName: R.nib.upgradeLevelTableViewCell.name, bundle: nil), forCellReuseIdentifier: R.nib.upgradeLevelTableViewCell.name)
        
    }
    
    private func getProfileLevel(){
        self.viewModel = UpgradeLevelViewModel()
        self.viewModel.getProfileLevel { response in
            DispatchQueue.main.async {
                self.updateTableView(response?.levelData)
            }
        }
    }
    
    //MARK:- UPDATE TABLE VIEW
    func updateTableView(_ items : [LevelData]?){
        self.dataSource = UpgradeLevelDataSource(cellIdentifier: R.nib.upgradeLevelTableViewCell.identifier, item: items ?? nil, configureCell: { cell, data, isExpandable in
            cell.configureCell(data: data!, isExpandable: isExpandable)
        }, didSelect: { id, levelData in
            print(id)
            
        }, didTapUpgrade: {
            self.showUpgradeLevelPopUp()
        })
        
        DispatchQueue.main.async {
            self.tblView.dataSource = self.dataSource
            self.tblView.delegate = self.dataSource
            self.tblView.reloadData()
        }
    }
    
    func showUpgradeLevelPopUp() {
        let controller = UpgradeLevelPopUpViewController.homeControl
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true, completion: nil)
        
    }
}
