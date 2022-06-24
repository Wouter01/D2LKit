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

public struct Announcement: Codable, Identifiable {
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
        isAuthorInfoShown: Bool?
}

public struct File: Codable {
    public let fileId: Int,
        fileName: String,
        size: Int
}

public struct Grade: Codable, Hashable, Identifiable {
    public enum ObjectType: Int, Codable, Hashable {
        case numeric = 1
        case passfail = 2
        case selectBox = 3
        case text = 4
        case calculated = 5
        case formula = 6
        case finalCalculated = 7
        case finalAdjusted = 8
        case category = 9
    }
    
   public let pointsNumerator: Float?,
        pointsDenominator: Float?,
        displayedGrade: String?,
        gradeObjectIdentifier: String,
        gradeObjectName: String,
        gradeObjectType: ObjectType,
        gradeObjectTypeName: String?,
        comments: Comment,
        privateComments: Comment,
        lastModified: String?,
        lastModifiedBy: Int?,
        releasedDate: String?
    
    public var subGrades: [Grade]?
    
    public var id: String {
        gradeObjectIdentifier
    }
    
    public var percentage: Double? {
        guard let pointsNumerator, let pointsDenominator else { return nil }
        return Double(pointsNumerator / pointsDenominator)
    }
}

public struct Comment: Codable, Hashable {
    public let text: String,
        html: String
}
