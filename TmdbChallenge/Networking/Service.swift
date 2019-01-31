//
//  Service.swift
//  TmdbChallenge
//
//  Created by Gina De La Rosa on 1/29/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//

import Foundation

class Service {
    
    // Using URLSession.shared to access the contents of a URL and make a request.
    var session = URLSession.shared
    
    // MARK: - Create URL from parameters and path extension.
    private func URLWithParameters(_ parameters: [String:AnyObject], withPathExtension: String? = nil) -> URL {
        
        //Creating an instance of URLComponents strucutre to parse a URL
        var components = URLComponents()
        //Set the properties below
        components.scheme = Api.SCHEME
        components.host = Api.HOST
        components.path = Api.PATH + (withPathExtension ?? "")
        components.queryItems = [URLQueryItem]()
        
        // Get the key's values from the parameters
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        // Getting the URL
        return components.url!
    }
    
    // MARK: - Handle Get Requests
    /// getMethod will have inputs such as method and parameters to assist with returning the proper downloaded data.
    func getMethod(_ method: String, parameters: [String: AnyObject], completionHandler: @escaping (_ result: Data?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        // Create a parameter with the API key 
        var parameterWithKey = parameters
        parameterWithKey[ParameterKeys.API_KEY] = Api.KEY as AnyObject?
        
        // Create the request with the api key
        let request = NSMutableURLRequest(url: URLWithParameters(parameterWithKey, withPathExtension: method))
        
        // Creates a task to retrive the URL
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            ///If there is an error we will send it
            func sendError(_ error: String) {
                print(error)
                //Will return the error description
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
    // Passing a closure to execute after the function gets executed
    func getImage(_ size: String, filePath: String, completionHandlerForImage: @escaping (_ imageData: Data?, _ error: NSError?) -> Void) -> URLSessionTask {
        
        let baseURL = URL(string: ImageKeys.IMAGE_BASE_URL)!
        let url = baseURL.appendingPathComponent(size).appendingPathComponent(filePath)
        //Creating a request based off the baseURL + url data
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            /// Send error if there is one
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
        //Resuming task if it is suspended
        task.resume()
        //Returning the URLSessionDataTask with the request
        return task
    }
}
