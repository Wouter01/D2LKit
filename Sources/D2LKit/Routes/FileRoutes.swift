//
//  File.swift
//  
//
//  Created by Wouter Hennen on 31/08/2022.
//

import Foundation

public extension APIRoutes {
    enum FileRoutes: APIRoute {
        
        public var platform: Service { .le }
        
        case toc(Course.ID)
        
        case file(Course.ID, Topic.ID)
        
        case lti(Course.ID, Topic.ID)
                
        public var url: URLComponents {
            switch self {
            case .toc(let courseID):
                return .init(path: "\(courseID)/content/toc")
            case .file(let courseID, let topicID):
                return .init(path: "\(courseID)/content/topics/\(topicID)/file", queryItems: [.init(name: "stream", value: "true")])
            case .lti(let courseID, let ltiURL):
                return .init(path: "lti/link/\(courseID)/\(ltiURL)")
            }
        }
    }
}
