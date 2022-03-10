//
//  MenuViewController.swift
//  Lifium
//
//  Created by Rajinder Kahlon on 02/03/22.
//

import UIKit
import SideMenuSwift
import AWSS3
import AWSCore

class MenuViewController: UIViewController {

    @IBOutlet weak var tblViewMenu: UITableView!
    
    let aryMenu = SideMenuModel.menu
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableCells()
    }
    
    private func registerTableCells() {
        tblViewMenu.register(UINib(nibName: R.nib.menuHeaderTableViewCell.name, bundle: nil), forCellReuseIdentifier: R.nib.menuHeaderTableViewCell.name)
        tblViewMenu.register(UINib(nibName: R.nib.menuTextTableViewCell.name, bundle: nil), forCellReuseIdentifier: R.nib.menuTextTableViewCell.name)
        tblViewMenu.register(UINib(nibName: R.nib.menuFooterTableViewCell.name, bundle: nil), forCellReuseIdentifier: R.nib.menuFooterTableViewCell.name)
    }


}
extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aryMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.menuHeaderTableViewCell.name, for: indexPath) as! MenuHeaderTableViewCell
            cell.editProfilePicButton.addTarget(self, action: #selector(btnEditProfilePicClicked), for: .touchUpInside)
            return cell
        case aryMenu.count - 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.menuFooterTableViewCell.name, for: indexPath) as! MenuFooterTableViewCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.menuTextTableViewCell.name, for: indexPath) as! MenuTextTableViewCell
            cell.iconImageView.image = aryMenu[indexPath.row].icon
            cell.lblTitle.text = aryMenu[indexPath.row].title
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sideMenuController?.hideMenu()
        switch indexPath.row {
        case 1:
            //manage profile
            return
        case 2:
            self.navigationController?.pushViewController(UpgradeLevelViewController.homeControl, animated: true)
            return
        case 3:
            self.navigationController?.pushViewController(LifiumCoinViewController.homeControl, animated: true)
            return
        case 5:
            self.navigationController?.pushViewController(SettingsViewController.control(isSettingScreen: true), animated: true)
            return
        case 6:
            self.navigationController?.pushViewController(SettingsViewController.control(isSettingScreen: false), animated: true)
            return
        default:
            return
        }

    }
}

//MARK: Image uploading
extension MenuViewController: ImagePickerManagerDelegate {
    
    
    @objc func btnEditProfilePicClicked() {
        ImagePickerManager.shared.openActionSheetForImages(onVC: self) { _ in }
    }
    
    @objc func btnShareClicked() {
        
    }
    
    func selectedImage(image: UIImage) {
        let imgName = "IMG_\(UUID().uuidString)"+".jpg"
        self.uploadS3(image: image, name: imgName) { progress in
            debugPrint(progress)
        } completionHandler: { error in
            
        }
    }
    func cancelToSelectImage() {
        
    }
    
}

extension MenuViewController {
    func uploadS3(image: UIImage,
                  name: String,
                  progressHandler: @escaping (Progress) -> Void,
                  completionHandler: @escaping (Error?) -> Void) {

        guard let data = image.jpegData(compressionQuality: S3Constants.shared.uploadImageQuality) else {
            DispatchQueue.main.async {
                debugPrint("Something went wrong")
                completionHandler(nil) // Replace your error
            }
            return
        }

        let credentialsProvider = AWSStaticCredentialsProvider(accessKey: S3Constants.shared.accessKeyS3, secretKey: S3Constants.shared.secretKeyS3)
        let configuration = AWSServiceConfiguration(region: S3Constants.shared.regionS3, credentialsProvider: credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        let expression = AWSS3TransferUtilityUploadExpression()
        expression.progressBlock = { task, progress in
            DispatchQueue.main.async {
                progressHandler(progress)
            }
        }

        AWSS3TransferUtility.default().uploadData(
            data,
            bucket: S3Constants.shared.bucketS3,
            key: name,
            contentType: "image/jpg",
            expression: expression) { task, error in
                
                if let err = error {
                    print("Failure")
                    print(err.localizedDescription)
                } else {
                    print("Success")
                    let imageURL = "http://s3.amazonaws.com/\(S3Constants.shared.bucketS3)/\(name)"
                    print("image url  = \(imageURL)")
                }
                DispatchQueue.main.async {
                    completionHandler(error)
                }

            }.continueWith { task -> AnyObject? in
                if let error = task.error {
                    DispatchQueue.main.async {
                        completionHandler(error)
                    }
                }
                return nil
        }
    }
}
