//
//  File.swift
//  
//
//  Created by Wouter Hennen on 01/09/2022.
//

import Foundation

public struct Module: Codable, Identifiable, Hashable {
    public let moduleId: Int,
               title: String,
               sortOrder: Int,
               startDateTime: String?,
               endDateTime: String?,
               modules: [Module],
               topics: [Topic],
               isHidden: Bool,
               isLocked: Bool,
               pacingStartDate: String?,
               pacingEndDate: String?,
               defaultPath: String,
               lastModifiedDate: String?
    
    public var id: Int { moduleId }
}
