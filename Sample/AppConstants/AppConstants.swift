//
//  AppConstants.swift
//  AppsMaven
//
//  Created by Sandip Gill on 16/12/20.
//  
//

import UIKit


enum APIHeaders{

    case accept
    case contentType
    case authorization
    case apiKey
}

enum APIStatusCode:Int{

    case success      = 200
    case unAuthorized = 401
    case pageNotFound = 404
    case unexpected   = 500
    case imageSuccess = 201

}

