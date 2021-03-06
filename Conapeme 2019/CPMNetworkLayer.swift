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
    
    
    
    func fastSignin(asisstantId:String,completion: @escaping (_ response:FastSigninResponse?,_ error:Error?) -> ()) {
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
                DispatchQueue.main.async {
                    completion(nil,responseError)
                }
                return
            }
            do {
                let response = try JSONDecoder().decode(FastSigninResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response,nil)
                }
            } catch let jsonErr {
                print(jsonErr)
            }
        }
        task.resume()
    }
    
    func expositorSignin(expositorId:String,completion: @escaping (_ response:ExpositorSigninResponse?,_ error:Error?) -> ()) {
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
                DispatchQueue.main.async {
                    completion(nil,responseError)
                    
                }
                return
            }
            
            do {
                let response = try JSONDecoder().decode(ExpositorSigninResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response,nil)
                }
                
            } catch let jsonErr {
                print(jsonErr)
            }
            
        }
        task.resume()
    }
    
    func fetchWorkshops(completion: @escaping (_ response:[Workshop]?,_ error:Error?) -> ()) {
        components.path = "/workshops"
        
        guard let url = components.url else { fatalError("Could not create URL from components") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard let data = responseData else {
                DispatchQueue.main.async {
                    completion(nil,responseError)
                }
                return
            }
            
            do {
                let response = try JSONDecoder().decode([Workshop].self, from: data)
                DispatchQueue.main.async {
                    completion(response,nil)
                }
                
            } catch let jsonErr {
                print(jsonErr)
            }
            
        }
        task.resume()
    }
    
    func addAssistanceToWorkshop(assistantId:Int,workshopId:Int,logisticsId:String,completion: @escaping (_ response:GenericSuccesResponse<SQLResult>?,_ error:Error?) -> ()) {
        components.path = "/assistances"
        
        guard let url = components.url else { fatalError("Could not create URL from components") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        let parameter = AddAssitanceToWorkshopRequestParameters(assistantId:assistantId,workshopId:workshopId,logisticsId:logisticsId)
        
        request.httpBody = encodeToJson(parameters: parameter)
        
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard let data = responseData else {
                DispatchQueue.main.async {
                    completion(nil,responseError)
                }
                return
            }
            
            do {
                let response = try JSONDecoder().decode(GenericSuccesResponse<SQLResult>.self, from: data)
                DispatchQueue.main.async {
                    completion(response,nil)
                }
                
            } catch let jsonErr {
                print(jsonErr)
            }
            
        }
        task.resume()
    }
    
    func fetchAssistantsFor(workshopId:Int,completion: @escaping (_ response:GenericSuccesResponse<[WorkshopAssistant]>?,_ error:Error?) -> ()) {
        components.path = "/workshops/assistants"
        
        guard let url = components.url else { fatalError("Could not create URL from components") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        let parameter = WorkshopAssistantsRequestParameter(workshopId:workshopId)
        
        request.httpBody = encodeToJson(parameters: parameter)
        
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard let data = responseData else {
                DispatchQueue.main.async {
                    completion(nil,responseError)
                }
                return
            }
            
            do {
                let response = try JSONDecoder().decode(GenericSuccesResponse<[WorkshopAssistant]>.self, from: data)
                DispatchQueue.main.async {
                    completion(response,nil)
                }
                
            } catch let jsonErr {
                print(jsonErr)
            }
            
        }
        task.resume()
    }
    
    
}
