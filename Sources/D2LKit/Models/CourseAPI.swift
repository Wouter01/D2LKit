//
//  CourseAPI.swift
//  Hyperion
//
//  Created by Wouter Hennen on 18/01/2021.
//

import Foundation

public enum CourseType {
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
    
    public var id: Int {
        info.orgUnit.id
    }
    
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(info)
    }
    
    
    public mutating func fetchGrades() async {
        let tempGrades: Result<[Grade], APIError> = await APIRoutes.Grades.grades(courseId: id).get()
        // Check if grades are correctly fetched.
        guard case .success(var newGrades) = tempGrades else {
            grades = tempGrades
            return
        }
        
        // Check if there are any categories in grades. If not, we're done.
        guard newGrades.contains(where: { $0.gradeObjectType == .category }) else {
            grades = tempGrades
            return
        }
        
        // Fetch the categories of the course.
        let categoriesResult: APIData<[GradeObjectCategory]> = await APIRoutes.Grades.categories(courseId: id).get()
        
        // Check if the categories are correctly fetched.
        guard case .success(let categories) = categoriesResult else {
            if case .failure(let failure) = categoriesResult {
                grades = .failure(failure)
            }
            return
        }
        
        // Add the subgrades to the category grade and remove them from the root list.
        categories.forEach { category in
            let index = newGrades.firstIndex { $0.id == String(category.id) }!
            let subGradeIds = category.grades.map { String($0.id) }
            newGrades[index].subGrades = newGrades.filter { subGradeIds.contains($0.id) }
            newGrades.removeAll { grade in
                subGradeIds.contains(grade.id)
            }
        }
        
        grades = .success(newGrades)
    }
    
    public mutating func fetchUsers() async {
        users = await APIRoutes.Users.users(courseId: id).get()
    }
    
}





