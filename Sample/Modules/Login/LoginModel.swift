//
//  LoginModel.swift
//  AppsMaven
//
//  Created by Sandip Gill on 16/12/20.
//

import UIKit

class LoginModel: NSObject,LoginModelProtocols {
    

    weak var loginViewModel: LoginViewModel?
    
    func callLoginApi(params: [String : Any]) {
        
        ApiManager.shared.request(endpoint: "", method: .post, headers: [.accept], params: params, isShowLoader: true) { (data) in
            
            let loginEntity = AppManager.shared.decode(modelType: LoginEntity.self, data: data)
            
            self.loginViewModel?.loggedIn(loginEntity: loginEntity)
        }
    }
    
}
