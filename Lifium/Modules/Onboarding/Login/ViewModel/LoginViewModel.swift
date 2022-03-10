//
//  LoginViewModel.swift
//  Lifium
//
//  Created by Hakikat Singh on 27/02/22.
//

import Foundation

class LoginViewModel: NSObject{
    
    private var apiService : OnboardingWebService!
    var bindViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService =  OnboardingWebService()
    }

    
    //MARK:- CALL LOGIN API
    func login(_ model : RequestLoginModel, _ completion : @escaping(_ : Bool, _ : String?)-> Void){
        self.apiService.getOTP(model) { response, error in
            if response != nil && error == nil{
                completion(true, nil)
            }else{
                completion(false, error)
            }
        }
    }
    
}
