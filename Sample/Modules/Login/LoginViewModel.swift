//
//  LoginViewModel.swift
//  AppsMaven
//
//  Created by Sandip Gill on 16/12/20.
//

import UIKit

class LoginViewModel: NSObject,LoginViewModelProtocols {
    
    weak var loginView : LoginView?
    weak var loginModel : LoginModel?
    
    static func initilize() -> LoginView {
        
        let loginView = R.storyboard.main.loginView()
        let loginViewModel = LoginViewModel()
        let loginModel = LoginModel()
        
        loginViewModel.loginView = loginView
        loginViewModel.loginModel = loginModel
        
        loginModel.loginViewModel = loginViewModel
        
        loginView!.loginViewModel = loginViewModel
        
        return loginView!
    }
    
    func loginPressed() {
        
        if self.validateData(){
            let params = ["":""]
            self.loginModel?.callLoginApi(params: params)
        }
    }
    
    func loggedIn(loginEntity: LoginEntity) {
        //TODO: - - Handle response and move to next screen accordingly
    }
    
    private func validateData() -> Bool{
        
        //TODO: - - Validate Data according to requirements
        return true
    }
}

