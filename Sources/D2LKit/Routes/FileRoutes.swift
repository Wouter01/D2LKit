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
        case module(Course.ID, Topic.ID)
        case file(Course.ID, Topic.ID)
        case lti(Course.ID, Topic.ID)
                
        public var url: URLComponents {
            switch self {
            case .toc(let courseID):
                return .init(path: "\(courseID)/content/toc")
            case .module(let courseID, let topicID):
                return .init(path: "\(courseID)/content/modules/\(topicID)")
            case .file(let courseID, let topicID):
                return .init(path: "\(courseID)/content/topics/\(topicID)/file", queryItems: [.init(name: "stream", value: "true")])
            case .lti(let courseID, let ltiURL):
                return .init(path: "lti/link/\(courseID)/\(ltiURL)")
            }
        }

        public static func getToc(for course: Course.ID) async throws -> [String: [Module]] {
            try await toc(course).fetch()
        }

        public static func downloadFile(with id: Topic.ID, in course: Course.ID, to url: URL, delegate: DownloadProgressDelegate? = nil) async throws {
            try await file(course, id).download(to: url, delegate: delegate)
        }

        public static func getModule(in course: Course.ID, with id: Topic.ID) async throws -> ContentObject {
            try await module(course, id).fetch()
        }
    }
}
