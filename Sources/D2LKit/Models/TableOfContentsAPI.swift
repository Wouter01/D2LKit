////
//  TableOfContentsAPI.swift
//  Hyperion
//
//  Created by Wouter Hennen on 23/01/2021.
//
//  Copyright © 2020 Wouter Hennen
//  Licensed under the Apache License, Version 2.0
//

import Foundation

public struct TableOfContents: Codable {
    var modules: [Module]
}

public struct Module: Codable {
    let moduleId: Int,
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

}

// Used for the expandable list of contents.
// This is needed because every item needs to be of the same kind.
public struct Either: Codable, Identifiable {
    public let id: Int,
        title: String,
        modules: [Either]?,
        topic: Topic?,
        lastModifiedDate: String?
}

public struct Topic: Codable {
    let topicId: Int,
        identifier: String,
        typeIdentifier: String,
        title: String,
        bookmarked: Bool,
        unread: Bool,
        url: String,
        sortOrder: Int,
        startDateTime: String?,
        endDateTime: String?,
        activityId: String?,
        completionType: Int,
        isExempt: Bool,
        isHidden: Bool,
        isLocked: Bool,
        isBroken: Bool,
        toolId: Int?,
        toolItemId: Int?,
        activityType: Int,
        gradeItemId: Int?,
        lastModifiedDate: String?
}

public struct ObjectData: Codable {

    // Shared variables
    let isHidden: Bool,
        isLocked: Bool,
        id: String,
        title: String,
        shortTitle: String,
        type: Int,
        description: String?,
        parentModuleId: Int?,
        duration: Int?,
        lastModifiedDate: String?

    // Module variables
    let structure: [ObjectData],
        moduleStartDate: String?,
        moduleEndDate: String?,
        moduleDueDate: String?

    // Topic variables
    let topicType: Int?,
        url: String?,
        startDate: String?,
        endDate: String,
        dueDate: String,
        activityId: String?,
        isExempt: Bool,
        toolId: Int?,
        toolItemId: Int?,
        activityType: Int?,
        gradeItemId: Int?
}
