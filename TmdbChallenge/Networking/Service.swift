//
//  Service.swift
//  TmdbChallenge
//
//  Created by Gina De La Rosa on 1/29/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//

import Foundation

class Service {
    
    var session = URLSession.shared
    
    // MARK: - Create URL from parameters
    private func URLWithParameters(_ parameters: [String:AnyObject], withPathExtension: String? = nil) -> URL {
        
        var components = URLComponents()
        components.scheme = Api.SCHEME
        components.host = Api.HOST
        components.path = Api.PATH + (withPathExtension ?? "")
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }
    
    // MARK: - Handle Get Requests
    func getMethod(_ method: String, parameters: [String: AnyObject], completionHandler: @escaping (_ result: Data?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        // Setup request
        var parameterWithKey = parameters
        parameterWithKey[ParameterKeys.API_KEY] = Api.KEY as AnyObject?
        let request = NSMutableURLRequest(url: URLWithParameters(parameterWithKey, withPathExtension: method))
        
        // Make Request
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandler(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            // Handle error
            guard (error == nil) else {
                sendError("There was an error with your request: \(String(describing: error))")
                return
            }
            
            // Get data
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            // Return data
            completionHandler(data, nil)
        }
        // Start the request
        task.resume()
        return task
    }
    
    // MARK: - Handle Get Image Requests
    
    func getImage(_ size: String, filePath: String, completionHandlerForImage: @escaping (_ imageData: Data?, _ error: NSError?) -> Void) -> URLSessionTask {
        
        let baseURL = URL(string: ImageKeys.IMAGE_BASE_URL)!
        let url = baseURL.appendingPathComponent(size).appendingPathComponent(filePath)
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForImage(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            // Check for error
            guard (error == nil) else {
                sendError("There was an error with your request: \(String(describing: error))")
                return
            }
            // Get data
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            // Return image data
            completionHandlerForImage(data, nil)
        }
        
        task.resume()
        return task
    }
}
