//
//  File.swift
//  
//
//  Created by Wouter Hennen on 23/06/2022.
//

import Foundation

public enum Service: String {
    case lp = "/d2l/api/lp/1.37/"
    case le = "/d2l/api/le/1.50/"
}

public class D2LUserRequest {
    var appId: String,
        appKey: String,
        userId: String,
        userKey: String,
        baseURL: URL
    
    public init(appId: String, appKey: String, userId: String, userKey: String, baseURL: URL) {
        self.appId = appId
        self.appKey = appKey
        self.userId = userId
        self.userKey = userKey
        self.baseURL = baseURL
    }
    
    public enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    
    /// Build an authenticated URL, which can be used to make requests to a Brightspace server.
    /// - Parameters:
    ///   - method: HTTP method to send to the server. Default is GET.
    ///   - service: One of the Brightspace [services](https://docs.valence.desire2learn.com/about.html#api-deprecation-and-obsolescence).
    ///   - url: Unauthenticated URL. This URL should only contain the path and queries (and not the hostname).
    public func build(_ method: HTTPMethod = .get, using service: Service?, for url: inout URLComponents) {
        // Add base path to the url.
        if let service {
            url.path = service.rawValue + url.path
        }
        
        // Format signature
        let time = Int64(Date.now.timeIntervalSince1970)
        let data = "\(method.rawValue)&\(url.path.lowercased())&\(time)"

        // Add authentication queries.
        url.queryItems = (url.queryItems ?? []) + [
            .init(name: "x_a", value: appId),
            .init(name: "x_b", value: userId),
            .init(name: "x_c", value: D2LManager.createHMAC(key: appKey, data: data)),
            .init(name: "x_d", value: D2LManager.createHMAC(key: userKey, data: data)),
            .init(name: "x_t", value: "\(time)")
        ]
        
        // Add host to the url.
        url.host = baseURL.host()
        url.scheme = baseURL.scheme
    }
    
    public func building(_ method: HTTPMethod = .get, using service: Service?, for url: URLComponents) -> URLComponents {
        var url = url
        self.build(using: service, for: &url)
        return url
    }
}
