//
//  Movie_Results.swift
//  TmdbChallenge
//
//  Created by Gina De La Rosa on 1/29/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//  Adopting Codable (combines Encodable and Decodable) to convert data types into readable JSON.

import Foundation

//  Created a struct to define the movie results properties.
// The variables declared are using type annotations to indicate the type of vlaue it will be.

struct MovieResults: Codable {
    var results: [Movie]?
    var total_pages: Int?
    var total_results: Int?
    
    //Decoding an instance of movie results into json objects.
    static func decode(jsonData: Data) -> MovieResults? {
        let decoder = JSONDecoder()
        do {
            //Will try to decode/create the movie results and if it fails we will recieve an error.
            let result = try decoder.decode(MovieResults.self, from: jsonData)
            return result
            //To be safe, we are using catch to make sure we know we received an error. 
        } catch let error {
            print("Failed decoding with error: \(error)")
            return nil
        }
    }
}
