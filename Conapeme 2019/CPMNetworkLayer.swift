//
//  CPMNetworkLayer.swift
//  Conapeme 2019
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 2/20/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation



final class CPMNetworkLayer {
    var components = URLComponents()
    
    init() {
        components.scheme = "https"
        components.host = "frozen-thicket-85183.herokuapp.com"
    }
    
    func encodeToJson<T:Codable>(parameters:T)-> Data? {
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(parameters)
            return jsonData
        } catch {
            return nil
        }
    }
    
    
    
    func fastSignin(asisstantId:String,completion: @escaping (_ response:FastSigninResponse) -> ()) {
        components.path = "/assistant/signin"
        
        guard let url = components.url else { fatalError("Could not create URL from components") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        
        let parameter = FastSigninRequestParameters(assistantId:asisstantId)
        
        request.httpBody = encodeToJson(parameters: parameter)
        
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard let data = responseData else {
                
                return
            }
            
           
            do {
                let response = try JSONDecoder().decode(FastSigninResponse.self, from: data)
                let ds = String(data: data, encoding: .utf8)
                DispatchQueue.main.async {
                    completion(response)
                }
                
            } catch let jsonErr {
                print(jsonErr)
            }
            
        }
        task.resume()
    }
    
    func expositorSignin(expositorId:String,completion: @escaping (_ response:ExpositorSigninResponse) -> ()) {
        components.path = "/expositors/signin"
        
        guard let url = components.url else { fatalError("Could not create URL from components") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        
        let parameter = ExpositorSigninRequestParameters(expositorId:expositorId)
        
        request.httpBody = encodeToJson(parameters: parameter)
        
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard let data = responseData else {
                
                return
            }
            
            do {
                let response = try JSONDecoder().decode(ExpositorSigninResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response)
                }
                
            } catch let jsonErr {
                print(jsonErr)
            }
            
        }
        task.resume()
    }
    
    
}
