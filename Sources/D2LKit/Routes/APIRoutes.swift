//
//  File.swift
//  
//
//  Created by Wouter Hennen on 24/06/2022.
//

import Foundation

/// Collection of all the defined routes to the D2L API.
public enum APIRoutes {
    
    public static func get<A: Codable>(url: URLComponents) async -> Result<A, APIError> {
        do {
            var urlcomponents = url
            D2LManager.shared.builder?.build(using: nil, for: &urlcomponents)
            guard let url = urlcomponents.url else { return .failure(.buildURLError) }
            
            let (data, resp) = try await URLSession.shared.data(from: url)
            //            print(String(data: data, encoding: .utf8))
            if let code = (resp as? HTTPURLResponse)?.statusCode, code != 200 {
                return .failure(.statusCodeError(statusCode: code))
            }
            if let result = A.init(jsonData: data) {
                return .success(result)
            }
            return .failure(.decodeError)
        } catch let error {
            return .failure(.fetchError(description: error.localizedDescription))
        }
    }
    
}
