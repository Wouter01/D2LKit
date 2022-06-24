//
//  File.swift
//  
//
//  Created by Wouter Hennen on 24/06/2022.
//

import Foundation

public struct MyOrgUnitInfo: Codable, Hashable {
    public let orgUnit: OrgUnitInfo,
               access: Access,
               pinDate: String?
    
    public struct Access: Codable, Hashable {
        public let isActive: Bool,
                   startDate: String?,
                   endDate: String?,
                   canAccess: Bool,
                   classlistRoleName: String?,
                   lISRoles: [String]?,
                   lastAccessed: Date?
    }
    
    
    public var label: String {
        orgUnit.name.contains("-") ? String(orgUnit.name.drop { $0 != "-" }.dropFirst(2)) : orgUnit.name
    }
}
