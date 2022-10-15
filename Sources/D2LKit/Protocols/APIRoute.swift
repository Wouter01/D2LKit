//
//  File.swift
//  
//
//  Created by Wouter Hennen on 24/06/2022.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case head = "HEAD"
    case patch = "PATCH"
    case put = "PUT"
}

public protocol APIRoute {
    var platform: Service { get }
    
    var url: URLComponents { get }

    var httpMethod: HTTPMethod { get }
    
    func fetch<A: Codable>() async throws -> A
}

public extension APIRoute {
    var httpMethod: HTTPMethod { .get }
    
    var generatedURL: URL {
        get throws {
            var urlcomponents = url
            urlcomponents.port = 443
            
            guard let builder = D2LManager.shared.builder else {
                throw APIError.noBuilderPresentError
            }
            
            builder.build(httpMethod, using: platform, for: &urlcomponents)
            guard let url = urlcomponents.url else { throw APIError.buildURLError }
            return url
        }
    }
    
    nonisolated func fetch<A: Codable>() async throws -> A {
        do {
            var request = try URLRequest(url: generatedURL)
            request.httpMethod = httpMethod.rawValue

            let (data, resp) = try await URLSession.shared.data(for: request)

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

    @discardableResult
    nonisolated func fetchRaw() async throws -> Data {
        do {
            var request = try URLRequest(url: generatedURL)
            request.httpMethod = httpMethod.rawValue

            let (data, resp) = try await URLSession.shared.data(for: request)

            if let code = (resp as? HTTPURLResponse)?.statusCode, code != 200 {
                throw APIError.statusCodeError(statusCode: code)
            }
            return data
        } catch let error {
            print(error)
            throw APIError.fetchError(description: error.localizedDescription)
        }
    }
    
    nonisolated func download(to url: URL, delegate: URLSessionTaskDelegate? = nil) async throws {
        do {
            
            let (fileURL, resp) = try await URLSession.shared.download(from: generatedURL, delegate: delegate)

            _ = url.startAccessingSecurityScopedResource()
                  
            defer { url.stopAccessingSecurityScopedResource() }

            print(url)
            
            if !FileManager.default.fileExists(atPath: url.deletingLastPathComponent().absoluteString) {
                try FileManager.default.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
            }
            if FileManager.default.fileExists(atPath: url.absoluteString) {
                print("File exists")
            }
            try? FileManager.default.removeItem(at: url)
            print("Moving \(fileURL) to \(url)")
            try FileManager.default.moveItem(at: fileURL, to: url)
            
            if let code = (resp as? HTTPURLResponse)?.statusCode, code != 200 {
                throw APIError.statusCodeError(statusCode: code)
            }
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
