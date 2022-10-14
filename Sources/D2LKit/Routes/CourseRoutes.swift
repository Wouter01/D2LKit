//
//  File.swift
//  
//
//  Created by Wouter Hennen on 24/06/2022.
//

import Foundation

typealias Courses = APIRoutes.Courses

extension APIRoutes {
    
    public enum Courses: APIRoute {
        public var platform: Service { .lp }
        
        public var url: URLComponents {
            switch self {
            case .courseSemesterInfo(let courseIds):
                let csv = courseIds.map { String($0) }.joined(separator: ",")
                return .init(path: "courses/parentorgunits", queryItems: [
                    .init(name: "orgUnitIdsCSV", value: csv)
                ])
                
            case .courses:
                return .init(path: "enrollments/myenrollments/", queryItems: [
                    .init(name: "sortBy", value: "-StartDate"),
                    .init(name: "sortBy", value: "-PinDate"),
                    .init(name: "orgUnitTypeId", value: "3")
                ])
            case .pin(let id):
                return .init(path: "enrollments/myenrollments/\(id)/pin")
            case .unpin(let id):
                return .init(path: "enrollments/myenrollments/\(id)/pin")
            }
        }
        public var httpMethod: HTTPMethod {
            switch self {
            case .pin(_):
                return .post
            case .unpin(_):
                return .delete
            default:
                return .get
            }
        }
        
        case courses
        case courseSemesterInfo(courseIds: [Course.ID])
        case pin(courseID: Course.ID)
        case unpin(courseID: Course.ID)
    }
    
}

