//
//  UpgradeLevelViewModel.swift
//  Lifium
//
//  Created by Hakikat Singh on 06/03/22.
//

import Foundation

class UpgradeLevelViewModel: NSObject{
    
    private var apiService : UserWebService!
    
    override init() {
        super.init()
        self.apiService =  UserWebService()
    }
    
    
    //MARK:- GET LEVEL API
    func getProfileLevel( _ completion : @escaping(_ : BaseUpgradeLevelClass?)-> Void){
        self.apiService.getLevel({ response, error in
            if response != nil && error == nil{
                completion(response)
            }
        })
    }
}
