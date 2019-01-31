//
//  Movie.swift
//  TmdbChallenge
//
//  Created by Gina De La Rosa on 1/29/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//  Using Codable (combines Encodable and Decodable) to convert data types into readable JSON.

import Foundation
// Created a struct to define the movie model properties.
// The variables declared are using type annotations to indicate the type of vlaue it will be.

struct Movie: Codable {
    let title: String?
    let overview: String?
    var poster_path: String?
    let backdrop_path: String?
}
