//
//  UserAPI.swift
//  Hyperion
//
//  Created by Wouter Hennen on 18/01/2021.
//
//  Copyright © 2020 Wouter Hennen
//  Licensed under the Apache License, Version 2.0
//

import Foundation

// API call:
// "/d2l/api/lp/1.0/users/whoami"
public struct WhoAmI: Codable {
    let firstName: String?
    let identifier: String?
    let lastName: String?
    let profileIdentifier: String?
    let uniqueName: String?
}

public struct OrgUnitUser: Codable {
    let user: User
    let role: RoleInfo
}

public struct User: Codable {
    let identifier: String?
    let displayName: String?
    let emailAddress: String?
    let orgDefinedId: String?
    let profileBadgeUrl: String?
    let profileIdentifier: String?
}

public struct RoleInfo: Codable, Hashable {
    let id: Int
    let code: String?
    let name: String
}

// API call:
// "/d2l/api/lp/1.0/profile/user/195"
public struct UserProfile: Codable {
    let nickname: String?
    let birthday: Birthday?
    struct Birthday: Codable {
        let month: Int
        let day: Int
    }
    let homeTown: String?
    let email: String?
    let homePage: String?
    let homePhone: String?
    let businessPhone: String?
    let mobilePhone: String?
    let faxNumber: String?
    let address1: String?
    let address2: String?
    let city: String?
    let province: String?
    let postalCode: String?
    let country: String?
    let company: String?
    let jobTitle: String?
    let highSchool: String?
    let university: String?
    let hobbies: String?
    let favMusic: String?
    let favTVShows: String?
    let favMovies: String?
    let favBooks: String?
    let favQuotations: String?
    let favWebSites: String?
    let futureGoals: String?
    let favMemory: String?
    struct SocialMedia: Codable {
        let name: String?
        let url: String?
    }
    let socialMediaUrls: [SocialMedia]
    let profileIdentifier: String?
}

public struct ClasslistUser: Codable, Identifiable, Hashable {
    public typealias ID = String
    public typealias ProfileID = String
    
    public let identifier: ID,
        profileIdentifier: ProfileID,
        displayName: String,
        userName: String?,
        email: String?,
        firstName: String?,
        lastName: String?,
        roleId: Role?,
        lastAccessed: String?,
        isOnline: Bool
    
    public var id: String { identifier }
    
    public enum Role: Codable, Equatable, Hashable, RawRepresentable {
        case admin, assistant, student
        
        public init?(rawValue: Int) {
            switch rawValue {
            case 109: self = .admin
            case 117: self = .assistant
            case 116: self = .assistant
            default: self = .student
            }
        }
        
        public var rawValue: Int {
            switch self {
            case .admin: return 109
            case .assistant: return 117
            case .student: return 110 // Note: is not always 110
            }
        }
    }
}
