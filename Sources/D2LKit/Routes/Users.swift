//
//  File.swift
//  
//
//  Created by Wouter Hennen on 24/06/2022.
//

import Foundation

typealias Users = APIRoutes.Users

extension APIRoutes {
    
    public enum Users: APIRoute {
        
        case users(courseId: Int)
        
        public var platform: Service { .le }
        
        public var url: URLComponents {
            switch self {
            case .users(let courseId):
                return .init(path: "\(courseId)/classlist/")
            }
        }
    }
    
}
