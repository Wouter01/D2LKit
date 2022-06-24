//
//  JSONDecoder.swift
//  Ufora
//
//  Created by Wouter Hennen on 18/06/2022.
//

import Foundation

public extension JSONDecoder.DateDecodingStrategy {
    static let iso8601withFractionalSeconds = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        guard let date = formatter.date(from: string) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(string)")
        }
        return date
    }
}

public extension JSONDecoder.KeyDecodingStrategy {
    static var convertFromPascalCase: JSONDecoder.KeyDecodingStrategy {
        return .custom { keys -> CodingKey in
            // keys array is never empty
            let key = keys.last!
            // Do not change the key for an array
            guard key.intValue == nil else {
                return key
            }
            
            let codingKeyType = type(of: key)
            let newStringValue = key.stringValue.firstCharLowercased()
            
            return codingKeyType.init(stringValue: newStringValue)!
        }
    }
}
