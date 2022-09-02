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
    
    var generatedURL: URL {
        get throws {
            var urlcomponents = url
            
            guard let builder = D2LManager.shared.builder else {
                throw APIError.noBuilderPresentError
            }
            
            builder.build(using: platform, for: &urlcomponents)
            guard let url = urlcomponents.url else { throw APIError.buildURLError }
            return url
        }
    }
    
    nonisolated func fetch<A: Codable>() async throws -> A {
        do {
            let (data, resp) = try await URLSession.shared.data(from: generatedURL)

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
    
    nonisolated func fetchRaw() async throws -> Data {
        do {
            let (data, resp) = try await URLSession.shared.data(from: generatedURL)
            //            print(String(data: data, encoding: .utf8))
            if let code = (resp as? HTTPURLResponse)?.statusCode, code != 200 {
                throw APIError.statusCodeError(statusCode: code)
            }
            return data
        } catch let error {
            throw APIError.fetchError(description: error.localizedDescription)
        }
    }
    
    nonisolated func download(name: String, delegate: URLSessionTaskDelegate? = nil) async throws -> URL {
        do {
            let (fileURL, resp) = try await URLSession.shared.download(from: generatedURL, delegate: delegate)
            let newURL = fileURL.deletingLastPathComponent().appendingPathComponent(name)
            
            if FileManager.default.fileExists(atPath: newURL.absoluteString) {
                print("File exists")
            }
            try? FileManager.default.removeItem(at: newURL)
            try FileManager.default.moveItem(at: fileURL, to: newURL)
            
            if let code = (resp as? HTTPURLResponse)?.statusCode, code != 200 {
                throw APIError.statusCodeError(statusCode: code)
            }
            
            return newURL
        } catch let error {
            throw APIError.fetchError(description: error.localizedDescription)
        }
    }
    
    // Note: this works but will often download too much data.
    nonisolated func fileSize() async throws -> Int64 {
        do {
            let (bytes, resp) = try await URLSession.shared.bytes(from: generatedURL)
            bytes.task.cancel()
                        
            return resp.expectedContentLength
            
        } catch let error {
            throw APIError.fetchError(description: error.localizedDescription)
        }
    }
}
