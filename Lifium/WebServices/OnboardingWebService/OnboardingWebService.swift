//
//  OnboardingWebService.swift
//  Lifium
//
//  Created by Hakikat Singh on 27/02/22.
//

import Foundation
import SVProgressHUD

class OnboardingWebService: BaseWebService{
    
    static let shared = OnboardingWebService()
    
    //MARK:- GET OTP
    func getOTP( _ model : RequestLoginModel, _ completion : @escaping(_ : BaseModel?, _ error: String? )-> Void){
        SVProgressHUD.show()
        self.requestBaseApi(model.parameters, ApiConstants.shared.getOTP, .POST) { (response, status, error) in
            SVProgressHUD.dismiss()
            if status == true {
                do {
                    let data = try JSONDecoder().decode(BaseModel.self, from: response!)
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
    
    //MARK:- VERIFY OTP
    func verifyOTP( _ model : RequestVerifyOTP, _ completion : @escaping(_ : BaseCreateProfile?, _ error: String?)-> Void){
        SVProgressHUD.show()
        self.requestBaseApi(model.parameters, ApiConstants.shared.verifyOTP, .POST) { (response, status, error) in
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
            } else{
                completion(nil, error)
            }
        }
    }
    
    //MARK:- CREATE PROFILE
    func createProfile( _ model : RequestCreateProfile, _ completion : @escaping(_ : BaseCreateProfile?, _ error : String?)-> Void){
        SVProgressHUD.show()
        self.requestBaseApi(model.parameters, ApiConstants.shared.createProfile, .PATCH) { (response, status, errorString) in
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
                completion(nil, errorString)
            }
        }
    }
}
