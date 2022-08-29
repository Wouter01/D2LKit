//
//  CourseAPI.swift
//  Hyperion
//
//  Created by Wouter Hennen on 18/01/2021.
//

import SwiftUI

public enum CourseType: String {
    case course, infosite, other
}


public struct CourseParent: Codable, Hashable, Identifiable {
    public let courseOfferingId: String,
               semester: BaseOrgUnit?,
               department: BaseOrgUnit?
    
    public var isNonOasis: Bool? {
        semester?.name == "non-Oasis"
    }
    
    public var isInfoSite: Bool? {
        semester?.name == "infosites"
    }
    
    public var isCourse: Bool? {
        guard let isNonOasis, let isInfoSite else { return nil }
        return !isNonOasis && !isInfoSite
    }
    
    public var type: CourseType? {
        guard let isNonOasis, let isInfoSite else { return .none }
        return isNonOasis ? .other : isInfoSite ? .infosite : .course
    }
    
    public var id: Int { Int(courseOfferingId) ?? -1 }
}

public struct BaseOrgUnit: Codable, Hashable, Identifiable {
    public let identifier: String,
               name: String,
               code: String
    public var id: Int { Int(identifier) ?? -1 }
    
}

public struct OrgUnitInfo: Codable, Identifiable, Hashable {
    public let id: Int,
               type: OrgUnitTypeInfo,
               name: String,
               code: String?,
               homeUrl: URL?,
               imageUrl: URL?
}

public struct OrgUnitTypeInfo: Codable, Identifiable, Hashable {
    public let id: Int,
               code: String,
               name: String
}

public struct Course: Hashable, Identifiable {
    
    public static func == (lhs: Course, rhs: Course) -> Bool {
        lhs.info == rhs.info
    }
    
    public init(info: MyOrgUnitInfo) {
        self.info = info
    }
    
    public let info: MyOrgUnitInfo
    public var grades: Result<[Grade], APIError>?,
               users: Result<[ClasslistUser], APIError>?,
               parent: CourseParent?
    
    public typealias ID = Int
    public var id: ID {
        info.orgUnit.id
    }
    
    public var image: Data?
    
    public var isPinned: Bool {
        info.pinDate != nil
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(info)
    }
    
}





