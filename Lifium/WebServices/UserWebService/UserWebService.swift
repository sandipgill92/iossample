//
//  UserWebService.swift
//  Lifium
//
//  Created by Hakikat Singh on 06/03/22.
//

import Foundation
import SVProgressHUD

class UserWebService: BaseWebService{
    
    static let shared = UserWebService()
    
    //MARK:- GET USER LEVEL
    func getLevel(  _ completion : @escaping(_ : BaseUpgradeLevelClass?, _ error: String? )-> Void){
        SVProgressHUD.show()
        self.requestBaseApi(["":""], ApiConstants.shared.getUserLevel, .GET) { (response, status, error) in
            SVProgressHUD.dismiss()
            if status == true {
                do {
                    let data = try JSONDecoder().decode(BaseUpgradeLevelClass.self, from: response!)
                    if data.code == 200 {
                        completion(data, nil)
                    }else{
                        completion(nil, data.message)
                    }
                }catch{
                    completion(nil, error.localizedDescription)
                    print("error=\(error)")
                }
            }else{
                completion(nil, error)
            }
        }
    }
 
    //MARK:- UPGRADE USER LEVEL
    func upgradeUserLevel(level : String,  _ completion : @escaping(_ : BaseUpgradeLevelClass?, _ error: String? )-> Void){
//        SVProgressHUD.show()
//        self.requestBaseApi(["":""], ApiConstants.shared.upgradeLevel+level, .GET) { (response, status, error) in
//            SVProgressHUD.dismiss()
//            if status == true {
//                do {
//                    let data = try JSONDecoder().decode(BaseUpgradeLevelClass.self, from: response!)
//                    if data.code == 200 {
//                        completion(data, nil)
//                    }else{
//                        completion(nil, data.message)
//                    }
//                }catch{
//                    completion(nil, error.localizedDescription)
//                    print("error=\(error)")
//                }
//            }else{
//                completion(nil, error)
//            }
//        }
    }
    
    //MARK:- UPGRADE USER LEVEL
    func updateNotificationStatus(status : String,  _ completion : @escaping(_ : BaseCreateProfile?, _ error: String? )-> Void){
        SVProgressHUD.show()
        self.requestBaseApi(["":""], ApiConstants.shared.updateNotificationStatus+status, .PATCH) { (response, status, error) in
            SVProgressHUD.dismiss()
            if status == true {
                do {
                    let data = try JSONDecoder().decode(BaseCreateProfile.self, from: response!)
                    if data.code == 200 {
                        completion(data, nil)
                    }else{
                        completion(nil, data.message)
                    }
                }catch{
                    completion(nil, error.localizedDescription)
                    print("error=\(error)")
                }
            }else{
                completion(nil, error)
            }
        }
    }
}
