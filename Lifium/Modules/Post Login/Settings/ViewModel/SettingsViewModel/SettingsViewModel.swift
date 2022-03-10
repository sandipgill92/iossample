//
//  SettingsViewModel.swift
//  Lifium
//
//  Created by Sandip Gill on 07/03/22.
//

import Foundation

class SettingsViewModel: NSObject{
    
    private var apiService : UserWebService!
    
    override init() {
        super.init()
        self.apiService =  UserWebService()
    }
    
    
    //MARK:- SET NOTIFICATION STATUS API
    func setNotificationStatus( _ status : String ,_ completion : @escaping(_ : Bool?, _ : String?)-> Void){
        self.apiService.updateNotificationStatus(status: status) { response, error in
            if response != nil && error == nil{
                UserStore.shared.user = response?.profileData
                completion(response?.profileData?.isNotificationEnable ?? false, nil)
            }else{
                completion(false, error)
            }
        }
    }
}
