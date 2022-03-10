//
//  LoginProtocols.swift
//  AppsMaven
//
//  Created by Sandip Gill on 16/12/20.
//

import Foundation


/*
 View protocols
 */
protocol LoginViewProtocol {
    
}

/*
 Interactor protocols
 */
protocol LoginModelProtocols {
    func callLoginApi(params : [String : Any])
}

/*
 Presenter protocols
 */
protocol LoginViewModelProtocols {
    
    static func initilize() -> LoginView
    func loginPressed()
    func loggedIn(loginEntity : LoginEntity)
}
