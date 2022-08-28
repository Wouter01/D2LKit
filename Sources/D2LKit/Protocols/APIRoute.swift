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
    
    func fetch<A: Codable>() async throws -> A
}

public extension APIRoute {
    func fetch<A: Codable>() async throws -> A {
        do {
            var urlcomponents = url
            
            guard let builder = D2LManager.shared.builder else {
                throw APIError.noBuilderPresentError
            }
            
            builder.build(using: platform, for: &urlcomponents)
            guard let url = urlcomponents.url else { throw APIError.buildURLError }
            
            let (data, resp) = try await URLSession.shared.data(from: url)

            if let code = (resp as? HTTPURLResponse)?.statusCode, code != 200 {
                throw APIError.statusCodeError(statusCode: code)
            }
            
            if let result = A.init(jsonData: data) {
                return result
            }
            throw APIError.decodeError
            
        } catch let error {
            throw APIError.fetchError(description: error.localizedDescription)
        }
    }
    
    func fetchRaw() async throws -> Data {
        do {
            var urlcomponents = url
            
            guard let builder = D2LManager.shared.builder else {
                throw APIError.noBuilderPresentError
            }
            
            builder.build(using: platform, for: &urlcomponents)
            guard let url = urlcomponents.url else { throw APIError.buildURLError }
            
            let (data, resp) = try await URLSession.shared.data(from: url)
            //            print(String(data: data, encoding: .utf8))
            if let code = (resp as? HTTPURLResponse)?.statusCode, code != 200 {
                throw APIError.statusCodeError(statusCode: code)
            }
            return data
        } catch let error {
            throw APIError.fetchError(description: error.localizedDescription)
        }
    }
}
