//
//  File.swift
//  
//
//  Created by Wouter Hennen on 24/06/2022.
//

import Foundation

public protocol APIRoute {
    var platform: Service { get }
    
    var url: URLComponents { get }
    
    func get<A: Codable>() async -> Result<A, APIError>
}

public extension APIRoute {
    func get<A: Codable>() async -> Result<A, APIError> {
        do {
            var urlcomponents = url
            
            guard let builder = D2LManager.shared.builder else {
                return .failure(.noBuilderPresentError)
            }
            
            builder.build(using: platform, for: &urlcomponents)
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
