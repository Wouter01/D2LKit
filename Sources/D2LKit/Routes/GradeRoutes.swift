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
        case grades(courseId: Course.ID)
        case categories(courseId: Course.ID)
        
        public var platform: Service { .le }
        
        public var url: URLComponents {
            switch self {
            case .grades(let courseId):
                return .init(path: "\(courseId)/grades/values/myGradeValues/")
                
            case .categories(let courseId):
                return .init(path: "\(courseId)/grades/categories/")
            }
        }

        public static func getGrades(for course: Course.ID) async throws -> [Grade] {
            try await grades(courseId: course).fetch()
        }

        public static func getCategories(for course: Course.ID) async throws -> [GradeObjectCategory] {
            try await categories(courseId: course).fetch()
        }
    }
    
}
