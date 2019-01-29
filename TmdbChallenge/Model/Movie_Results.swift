//
//  Movie_Results.swift
//  TmdbChallenge
//
//  Created by Gina De La Rosa on 1/29/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//

import Foundation

struct MovieResults: Codable {
    var results: [Movie]?
    var total_pages: Int?
    var total_results: Int?
    
    static func decode(jsonData: Data) -> MovieResults? {
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(MovieResults.self, from: jsonData)
            return result
        } catch let error {
            print("Failed decoding with error: \(error)")
            return nil
        }
    }
}
