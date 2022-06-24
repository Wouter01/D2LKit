////
//  EventAPI.swift
//  Ufora
//
//  Created by Wouter Hennen on 22/05/2021.
//
//  Copyright © 2020 Wouter Hennen
//  Licensed under the Apache License, Version 2.0
//

import Foundation

typealias D2LID = Int
typealias DateTimeString = String

public struct ObjectsListPage<T: Codable>: Codable {
    var next: String?,
        objects: [T]
}

public struct D2LCalendarEvent: Codable {
    var calendarEventId: D2LID,
    orgUnitId: D2LID,
    title: String,
    description: String,
    startDateTime: DateTimeString?,
    endDateTime: DateTimeString?,
    isAllDayEvent: Bool,
    startDay: DateTimeString?,
    endDay: DateTimeString?,
    groupId: D2LID?,
    isRecurring: Bool,
    recurrenceInfo: CalendarRecurrenceInfo?,
    locationId: D2LID?,
    locationName: String,
    orgUnitName: String,
    orgUnitCode: String,
    isAssociatedWithEntity: Bool,
    associatedEntity: CalendarAssociatedEntityInfo?,
    hasVisibilityRestrictions: Bool,
    visibilityRestrictions: CalendarVisibilityInfo,
    calendarEventViewUrl: String,
    presenters: [CalendarPresenterInfo]

//    var descriptionParsed: [String] {
//        get {
//            do {
//                let parsed = try SwiftSoup.parse(description)
//                return try (parsed.select("p").map { $0.ownText() } + parsed.select("span").map { $0.ownText() }).filter { !$0.isEmpty }
////                return try XMLDocument(string: description).root?.stringValue ?? ""
//            } catch let error {
//                return ["error parsing description: \(error)"]
//            }
//        }
//    }
//
//    var descriptionLinks: [(String, String)] {
//        get {
//            do {
//                let parsed = try SwiftSoup.parse(description)
//                return try parsed.select("a").compactMap { try ($0.text(), $0.attr("href")) }
////                return try XMLDocument(string: description).root?.stringValue ?? ""
//            } catch let error {
//                return [("error parsing descriptionLinks: \(error)", "")]
//            }
//        }
//    }

}

public struct CalendarRecurrenceInfo: Codable {
    var repeatType: Int,
        repeatEvery: Int,
        repeatOnInfo: CalendarRepeatOnInfo,
        repeatUntilDate: DateTimeString
}

public struct CalendarRepeatOnInfo: Codable {
    var monday,
        tuesday,
        wednesday,
        thursday,
        friday,
        saturday,
        sunday: Bool
}

public struct CalendarAssociatedEntityInfo: Codable {
    var associatedEntityType: String,
        associatedEntityId: Int,
        link: String
}

public struct CalendarVisibilityInfo: Codable {
    var type: Int,
        range: Int?,
        hiddenRangeUnitType: Int?,
        startDate: String?,
        endDate: String?
}

public struct CalendarPresenterInfo: Codable {
    var userId: Int,
        name: String,
        role: String
}
