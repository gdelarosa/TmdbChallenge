//
//  Constants.swift
//  TmdbChallenge
//
//  Created by Gina De La Rosa on 1/29/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//

import Foundation

var posterSizes = ["w342"]

struct Methods {
    static let POPULAR_MOVIES = "/movie/popular"
}

struct Api {
    static let BASE_URL = "https://api.themoviedb.org/3"
    static let KEY = "5042406e2d9a46f8e330a6b89e997af4"
    static let SCHEME = "https"
    static let HOST = "api.themoviedb.org"
    static let PATH = "/3"
}

struct ParameterKeys {
    static let API_KEY = "api_key"
    static let PAGE = "page"
    static let TOTAL_RESULTS = "total_results"
}

struct ImageKeys {
    static let IMAGE_BASE_URL = "https://image.tmdb.org/t/p/"
    
    struct PosterSizes {
        static let POSTER = posterSizes[0]
    }
}

