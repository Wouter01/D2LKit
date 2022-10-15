//
//  File.swift
//  
//
//  Created by Wouter Hennen on 15/10/2022.
//

import Foundation

public struct ContentObject: Codable, Hashable {
    public var structure: [ContentObject]?,
        moduleStartDate: Date?,
        moduleEndDate: Date?,
        moduleDueDate: Date?,
        isHidden: Bool?,
        isLocked: Bool?,
        id: Int,
        title: String,
        shortTitle: String,
        type: Int,
        description: Comment?,
        parentModuleId: Int?,
        duration: Int?,
        lastModifiedDate: Date?
}
