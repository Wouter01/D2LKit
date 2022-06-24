//
//  File.swift
//  
//
//  Created by Wouter Hennen on 24/06/2022.
//

import Foundation

extension URLComponents {
    init(path: String, queryItems: [URLQueryItem]? = nil) {
        self.init()
        self.path = path
        self.queryItems = queryItems
    }
}
