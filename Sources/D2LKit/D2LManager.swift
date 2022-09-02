//
//  File.swift
//  
//
//  Created by Wouter Hennen on 23/06/2022.
//

import Foundation
import CryptoKit
import CommonCrypto

public class D2LManager {
    public static var shared = D2LManager()
    public var builder: D2LUserRequest?
    
    public static func buildLoginURL(appID: String, appKey: String, baseURL: URL, callbackURL: URL) throws -> URL {
        
        let hmacKey = createHMAC(key: appKey, data: callbackURL.absoluteString)
        let encodedURL = callbackURL.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        let url = URL(string: "\(baseURL.absoluteString)/d2l/auth/api/token?x_b=\(hmacKey)&x_target=\(encodedURL)&type=mobile&x_a=\(appID)")
        
        guard let url else {
            throw URLError(.badURL)
        }
        
        return url
    }
    
    /// Convert a Base 64 encoded string to the [https://datatracker.ietf.org/doc/html/rfc4648.html](RFC 4648) format.
    /// Specifically, '=' characters are removed, and '+' and '/' characters are replaced by '-' and '_'.
    /// - Parameter data: Base 64 encoded string
    /// - Returns: Formatted base 64 encoded string
    /// [https://docs.valence.desire2learn.com/basic/legacyauth.html?highlight=hmac#protocol-architecture](url)
    static func convertBase64String(data: String) -> String {
        data
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
    
    
    /// Create a valid HMAC for communication with the D2L API.
    /// - Parameters:
    ///   - appKey: The Appkey of the application.
    ///   - data: The callback url of the application.
    static func createHMAC(key: String, data: String) -> String {
        let hmacDigest = HMAC<SHA256>.authenticationCode(for: Data(data.utf8), using: .init(data: Data(key.utf8)))
        let base64Encoded = String(data: Data(hmacDigest).base64EncodedData(), encoding: .utf8)!
        return convertBase64String(data: base64Encoded)
    }
}
