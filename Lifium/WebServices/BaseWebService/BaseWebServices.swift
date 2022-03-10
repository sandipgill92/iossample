//
//  BaseWebServices.swift
//  Lifium
//
//  Created by Hakikat Singh on 27/02/22.
//

import UIKit
import SVProgressHUD

enum HTTPMethod : String{
    case PUT = "PUT"
    case POST = "POST"
    case GET = "GET"
    case DELETE = "DELETE"
    case PATCH = "PATCH"
}

enum Headers: String{
    case accept = "Accept"
    case contentType = "Content-Type"
    case accessToken = "accessToken"
    case userId = "userId"
    case userid = "userid"
    case authorization = "Authorization"
    case verifyType = "verifyType"
}

class BaseWebService: NSObject {
    
    var documentType : String = ""
    static var parameters : [String:Any] = [:]
    static var apiUrl : String = ""
    
    //MARK:- REQUEST POST API
    func requestBaseApi(_ parameters: [String:Any],_ url: String, _ httpMethod: HTTPMethod,_ completion: @escaping(_ :Data?, _ status: Bool, _ error : String?)-> Void){
        
        self.requestService(parameters: parameters, url: url,  httpMethod: httpMethod.rawValue) { (response, status, error) in
            completion(response, status, error)
        }
    }
    
    
    //MARK:- BASE API METHOD
    func requestService(parameters : Dictionary<String, Any>, url : String, httpMethod : String,_ completion: @escaping(_ :Data?, _ status: Bool, _ error : String?)-> Void){
        
        print("✅ Parameters ✅", parameters, "🌐 URL 🌐", url)
        
        guard let serviceUrl = URL(string: url) else { return }
        var request = URLRequest(url: serviceUrl)
        
        request.httpMethod = httpMethod
        request.timeoutInterval = 180
        request.setValue("application/json", forHTTPHeaderField: Headers.accept.rawValue)
        request.setValue("application/json", forHTTPHeaderField: Headers.contentType.rawValue)
        
        if UserStore.shared.user != nil {
            if let token = UserStore.shared.user?.accessToken{
                request.setValue(String(format: "Bearer %@", token), forHTTPHeaderField: Headers.accessToken.rawValue)
            }
        }
        
        if httpMethod == HTTPMethod.POST.rawValue || httpMethod == HTTPMethod.PATCH.rawValue{
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
                return
            }
            request.httpBody = httpBody
        }
        
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            if let response = response {
                print(response)
            }
            if let data = data {
                completion(data, true, nil)
            } else {
                completion(nil, false, error?.localizedDescription)
            }
            
        }.resume()
    }
    
    
    //MARK:- GET POST STRING
    func getPostString(params:[String:Any]) -> String{
        var data = [String]()
        for(key, value) in params{
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    
    func createBodyWithParameters(_ parameters:Dictionary<String, Any>, filePathKey: String?, imageData: Data?, boundary: String) -> Data {
        var body = Data();
        for (key, value) in parameters {
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(key)\"")
            body.append("\r\n\r\n\(value)\r\n")
        }
        if imageData != nil{
            let mimetype = "image/jpeg"
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"file.jpeg\"\r\n")
            body.append("Content-Type: \(mimetype)\r\n\r\n")
            body.append(imageData!)
            body.append("\r\n")
        }
        
        body.append("--\(boundary)--\r\n")
        
        return body
    }
    
    func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
