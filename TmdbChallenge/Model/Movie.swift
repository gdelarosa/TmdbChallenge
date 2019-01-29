//
//  Movie.swift
//  TmdbChallenge
//
//  Created by Gina De La Rosa on 1/29/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let title: String?
    let overview: String?
    var poster_path: String?
    let backdrop_path: String?
}
