//
//  File.swift
//  
//
//  Created by Wouter Hennen on 24/06/2022.
//

import Foundation

public enum APIError: Error, Hashable, CustomDebugStringConvertible, LocalizedError {
    case fetchError(description: String)
    case decodeError
    case statusCodeError(statusCode: Int)
    case buildURLError
    case noBuilderPresentError
    
    public var debugDescription: String {
        switch self {
        case .fetchError(let description):
            return "Fetch error: \(description)"
        case .decodeError:
            return "Decode error"
        case .statusCodeError(let statusCode):
            return "Statuscode error: \(statusCode)"
        case .buildURLError:
            return "Build URL error"
        case .noBuilderPresentError:
            return "The Authentication URL Builder is absent."
        }
    }
    
    public var errorDescription: String? {
        debugDescription
        
    }
    
}
