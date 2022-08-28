//
//  File.swift
//  
//
//  Created by Wouter Hennen on 28/08/2022.
//

import Foundation

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
