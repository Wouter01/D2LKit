//
//  File.swift
//  
//
//  Created by Wouter Hennen on 01/09/2022.
//

import Foundation

public struct Topic: Codable, Identifiable, Hashable {
    public typealias ID = Int
    
    public let topicId: Int,
               identifier: String,
               typeIdentifier: String,
               title: String,
               bookmarked: Bool,
               unread: Bool,
               
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
               activityType: ActivityType,
               gradeItemId: Int?,
               lastModifiedDate: String?
    
    let stringURL: String
    
    public var id: ID { topicId }
    
    public var fileSize: String?
    
    enum CodingKeys: String, CodingKey {
        case topicId
        case identifier
        case typeIdentifier
        case title
        case bookmarked
        case unread
        case sortOrder
        case startDateTime
        case endDateTime
        case activityId
        case completionType
        case isExempt
        case isHidden
        case isLocked
        case isBroken
        case toolId
        case toolItemId
        case activityType
        case gradeItemId
        case lastModifiedDate
        case stringURL = "url"
    }
    
    public var url: URL {
        URL(string: stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
    }
    
    
}
