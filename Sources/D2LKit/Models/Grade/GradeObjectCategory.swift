//
//  File.swift
//  
//
//  Created by Wouter Hennen on 24/06/2022.
//

import Foundation

/// [https://docs.valence.desire2learn.com/res/grade.html?highlight=grade+object+type#Grade.GradeObjectCategory](url)
public struct GradeObjectCategory: Codable, Hashable, Identifiable {
    public let id: Int,
               grades: [GradeObject]
    // Other fields are not implemented
    
    /// https://docs.valence.desire2learn.com/res/grade.html?highlight=grade+object+type#Grade.GradeObject
    public struct GradeObject: Codable, Hashable, Identifiable {
        public let id: Int
        // Other fields are not implemented
    }
}
