//
//  File.swift
//  
//
//  Created by Wouter Hennen on 23/06/2022.
//

import Foundation

extension Decodable {
    public init?(jsonData: Data, keyDecoding: JSONDecoder.KeyDecodingStrategy = .convertFromPascalCase, dateDecoding: JSONDecoder.DateDecodingStrategy = .iso8601withFractionalSeconds) {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = keyDecoding
            decoder.dateDecodingStrategy = dateDecoding
            self = try decoder.decode(Self.self, from: jsonData)
        } catch let error {
            print(error)
            return nil
        }
    }
    
    public init?(jsonString: String, keyDecoding: JSONDecoder.KeyDecodingStrategy = .convertFromPascalCase, dateDecoding: JSONDecoder.DateDecodingStrategy = .iso8601withFractionalSeconds) {
        guard let data = jsonString.data(using: .utf8) else {
            return nil
        }
        
        self.init(jsonData: data, keyDecoding: keyDecoding, dateDecoding: dateDecoding)
    }
}
