//
//  OtpViewModel.swift
//  Lifium
//
//  Created by Hakikat Singh on 27/02/22.
//

import Foundation

class OtpViewModel: NSObject{
    
    private var apiService : OnboardingWebService!
    var bindViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService =  OnboardingWebService()
    }

    
    //MARK:- CALL LOGIN API
    func verifyOTP(_ model : RequestVerifyOTP, _ completion : @escaping(_ : BaseCreateProfile?,_ : String?)-> Void){
        self.apiService.verifyOTP(model) { response, error in
            if response != nil && error == nil{
                UserStore.shared.user = response?.profileData
                completion(response, nil)
            }else{
                completion(nil, error)
            }
        }
    }
    
}
