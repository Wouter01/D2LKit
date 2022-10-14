//
//  File.swift
//  
//
//  Created by Wouter Hennen on 24/06/2022.
//

import Foundation
import AppKit

typealias Users = APIRoutes.Users

extension APIRoutes {
    
    public enum Users: APIRoute {
        
        case users(courseId: Int)
        
        case pagedUsers(courseId: Course.ID, searchTerm: String? = nil, next: URL? = nil)
        
        public var platform: Service { .le }
        
        public var url: URLComponents {

            switch self {
            case .users(let courseId):
                return .init(path: "\(courseId)/classlist/")
            
            case .pagedUsers(let courseId, let searchTerm, let next):
                if let next, let components = URLComponents(url: next, resolvingAgainstBaseURL: true) {
                    return .init(path: next.pathComponents.suffix(3).joined(separator: "/").appending("/"), queryItems: components.queryItems)
                }
                let queryItems: [URLQueryItem]
                if let searchTerm, !searchTerm.isEmpty {
                    queryItems = [.init(name: "searchTerm", value: searchTerm)]
                } else {
                    queryItems = []
                }
                return .init(path: "\(courseId)/classlist/paged/", queryItems: queryItems)
            }
        }

        public static func getUsers(for course: Course.ID) async throws -> BlockResultSet<ClasslistUser> {
            try await users(courseId: course).fetch()
        }

        public static func getPagedUsers(for course: Course.ID, searchTerm: String? = nil, next: URL? = nil) async throws -> BlockResultSet<ClasslistUser> {
            try await pagedUsers(courseId: course).fetch()
        }
    }
    
    public enum Profiles: APIRoute {
        
        case profileImage(profileId: String)
        
        public var platform: Service { .lp }
        
        public var url: URLComponents {
            switch self {
            case .profileImage(let profileId):
                return .init(path: "profile/\(profileId)/image")
            }
        }

        public static func getProfileImage(for profile: ClasslistUser.ProfileID) async throws -> NSImage {
            let data: Data = try await profileImage(profileId: profile).fetchRaw()
            if let image = NSImage(data: data) {
                return image
            }
            throw APIError.fetchError(description: "Could not decode image.")
        }
    }
}
