//
//  File.swift
//  
//
//  Created by Wouter Hennen on 24/06/2022.
//

import Foundation

public enum AuthError: Error {
    case hmacError
    case callbackURLError
    case urlCreationError
}
