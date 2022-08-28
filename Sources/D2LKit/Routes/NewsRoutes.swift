//
//  File.swift
//  
//
//  Created by Wouter Hennen on 28/08/2022.
//

import Foundation

extension APIRoutes {
    
    public enum News: APIRoute {
        public var platform: Service { .le }
        
        case courseNews(id: Course.ID)
        
        public var url: URLComponents {
            switch self {
            case .courseNews(let id):
                return .init(path: "\(id)/news/")
            }
        }
    }
    
}
