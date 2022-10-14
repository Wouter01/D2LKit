//
//  File.swift
//  
//
//  Created by Wouter Hennen on 24/06/2022.
//

import Foundation

typealias Courses = APIRoutes.Courses

public enum BoolVal {
    case enabled
    case disabled
}

extension APIRoutes {
    
    public enum Courses: APIRoute {

        public var platform: Service { .lp }

        case courses
        case courseSemesterInfo(courseIds: [Course.ID])
        case pin(courseID: Course.ID)
        case unpin(courseID: Course.ID)
        
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

            case .pin(let id), .unpin(let id):
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

        public static func getCourses() async throws -> PagedResultSet<MyOrgUnitInfo> {
            try await courses.fetch()
        }

        public static func getCourseSemesterInfo(courseIds: [Course.ID]) async throws -> [CourseParent] {
            try await courseSemesterInfo(courseIds: courseIds).fetch()
        }

        public static func updatePin(_ state: BoolVal, for id: Course.ID) async throws {
            switch state {
            case .enabled:
                try await pin(courseID: id).fetchRaw()
            case .disabled:
                try await unpin(courseID: id).fetchRaw()
            }
        }
    }
}

