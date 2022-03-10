//
//  CreateProfileViewModel.swift
//  Lifium
//
//  Created by Hakikat Singh on 28/02/22.
//

import Foundation

class CreateProfileViewModel: NSObject{
    
    private var apiService : OnboardingWebService!
    var bindViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService =  OnboardingWebService()
    }

    
    func createProfile(_ model : RequestCreateProfile, _ completion : @escaping(_ : Bool, _ error : String?)-> Void){
        self.apiService.createProfile(model) { response,error  in
            if response != nil && error == nil{
                UserStore.shared.user = response?.profileData
                completion(true, nil)
            }else{
                completion(false, error)
            }
        }
    }
    
}
