//
//  File.swift
//  
//
//  Created by Wouter Hennen on 24/06/2022.
//

import Foundation

/// Collection of all the defined routes to the D2L API.
public enum APIRoutes {
    
    public static func custom(for url: URL) throws -> URL {
        guard let builder = D2LManager.shared.builder else {
            throw APIError.noBuilderPresentError
        }
                
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw APIError.buildURLError
        }
        
        builder.build(using: nil, for: &components)
        
        guard let url = components.url else { throw APIError.buildURLError }
        return url
    }
    
}
