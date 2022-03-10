//
//  ApiManager.swift
//  AppsMaven
//
//  Created by Sandip Gill on 16/12/20.
//

import UIKit
import Alamofire

typealias callback = ((Data)->())

class ApiManager: NSObject {

    static let shared = ApiManager()

    //MARK: - - Call API
    func request(endpoint : String, method : HTTPMethod? = nil,headers:[APIHeaders] , params : [String:Any],isShowLoader : Bool? = nil, success : @escaping callback){

        let url = ApiConstants.baseUrl + endpoint
        
        let headers: HTTPHeaders? = self.appendHeaders(headerTypes:headers) ?? nil
        
        let request = AF.request(url, method: method!, parameters: params,
                                 encoding: JSONEncoding.default, headers: headers)
        request.responseJSON(completionHandler: { response in

            if let httpStatusCode = response.response?.statusCode{
                let statusCode = APIStatusCode.init(rawValue: httpStatusCode) ?? APIStatusCode(rawValue: 500)
                switch statusCode {
                case .success:
                    if let json = response.data{
                        // Handle result.
                        success(json)
                    }
                    break
                default:
                    self.handleErrorUsingStatusCode(statusCode: statusCode!)
                }
            }
        })
    }

    /*
     This function will return headers
     */
    private func appendHeaders(headerTypes:[APIHeaders]?) -> HTTPHeaders? {
        
        var headers = HTTPHeaders()
        if headerTypes != nil {
            for header in headerTypes!{
                
                switch header {
                case .accept:
                    headers["Accept"] = "application/json"
                    break
                case .contentType:
                    headers["Content-Type"] = "application/x-www-form-urlencoded" 
                    break
                case .authorization:
                    //TODO: - - Enter token here if required
                    headers["Authorization"] = "Bearer "
                    break
                case .apiKey:
                    headers["App-Key"] = "8UI93555755344234IZ"
                    break
                }
            }
        }
        return headers.count < 0 ? nil:headers
    }
    
    /*
     This function will handle errors according to status code
     */
    private func handleErrorUsingStatusCode(statusCode:APIStatusCode){
        
        switch statusCode {
        case .unAuthorized:
            AlertViewManager.showAlert(title: "", message: Errors.unauthorised, alertButtonTypes: [.Okay], alertStyle: .alert) { (buttonName) in
            
                //TODO: Logout the user or performed required action
            }
            break
        case .pageNotFound:
            AlertViewManager.showAlert(message: "", alertButtonTypes: [.Okay])
            break
        case .unexpected:
            AlertViewManager.showAlert(message: "", alertButtonTypes: [.Okay])
            break
        default:
            AlertViewManager.showAlert(message: "", alertButtonTypes: [.Okay])
            break
        }
    }

}
