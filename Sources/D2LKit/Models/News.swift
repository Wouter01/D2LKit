////
//  AnnouncementAPI.swift
//  Hyperion
//
//  Created by Wouter Hennen on 24/01/2021.
//
//  Copyright © 2020 Wouter Hennen
//  Licensed under the Apache License, Version 2.0
//

import Foundation

public struct News: Codable, Identifiable, Hashable {
    public let id: Int,
        isHidden: Bool,
        attachments: [File],
        title: String,
        body: Comment,
        createdBy: Int?,
        createdDate: String?,
        lastModifiedBy: Int?,
        lastModifiedDate: String?,
        startDate: String?,
        endDate: String?,
        isGlobal: Bool,
        isPublished: Bool,
        showOnlyInCourseOfferings: Bool,
        isAuthorInfoShown: Bool
}

public struct File: Codable, Hashable {
    public let fileId: Int,
        fileName: String,
        size: Int
}



public struct Comment: Codable, Hashable {
    public let text: String,
        html: String
}
