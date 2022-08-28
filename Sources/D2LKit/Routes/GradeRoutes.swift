//
//  File.swift
//  
//
//  Created by Wouter Hennen on 24/06/2022.
//

import Foundation

typealias Grades = APIRoutes.Grades

extension APIRoutes {
    
    public enum Grades: APIRoute {
        case grades(courseId: Int)
        case categories(courseId: Int)
        
        public var platform: Service { .le }
        
        public var url: URLComponents {
            switch self {
            case .grades(let courseId):
                return .init(path: "\(courseId)/grades/values/myGradeValues/")
                
            case .categories(let courseId):
                return .init(path: "\(courseId)/grades/categories/")
            }
        }
    }
    
}
