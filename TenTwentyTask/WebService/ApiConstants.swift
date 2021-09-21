//
//  APIConstants.swift
//  TenTwentyTask
//
//  Created by Arjun  on 30/12/20.
//  Copyright © 2020 Raj. All rights reserved.
//

import Foundation

enum APIConstants: String {
    static let pathTest = "https://api.themoviedb.org/3/movie/"
//popular?api_key=30e4e0a732822658641a261c013c8599
    case popular = "popular"
    
    var url: String {
            return APIConstants.pathTest + rawValue
        }
    
}
