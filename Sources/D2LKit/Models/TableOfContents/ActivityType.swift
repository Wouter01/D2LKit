//
//  File.swift
//  
//
//  Created by Wouter Hennen on 01/09/2022.
//

import Foundation

public enum ActivityType: Int, Codable, Identifiable, Hashable {
    case unknown = -1
    case module = 0
    case file = 1
    case link = 2
    case dropbox = 3
    case quiz = 4
    case discussionForum = 5
    case discussionTopic = 6
    case lti = 7
    case chat = 8
    case schedule = 9
    case checklist = 10
    case selfAssessment = 11
    case survey = 12
    case onlineRoom = 13
    case scorm_1_3 = 20
    case scorm_1_3_root = 21
    case scorm_1_2 = 22
    case scorm_1_2_root = 23
    
    public var id: ActivityType { self }
    
    public var icon: String {
        switch self {
        case .module:
            return "folder"
        case .file:
            return "doc.text"
        case .link:
            return "link"
        case .dropbox:
            return "shippingbox"
        case .quiz:
            return "die.face.5"
        case .discussionForum:
            return "person.crop.circle.badge.questionmark"
        case .discussionTopic:
            return "quote.bubble"
        case .lti:
            return "puzzlepiece.extension"
        case .chat:
            return "bubble.left.and.bubble.right"
        case .schedule:
            return "calendar.badge.clock"
        case .checklist:
            return "checklist"
        case .selfAssessment:
            return "person.crop.circle.badge.questionmark.fill"
        case .survey:
            return "list.dash.header.rectangle"
        case .onlineRoom:
            return "person.3.sequence"
        default:
            return "questionmark.app.dashed"
        }
    }
}
