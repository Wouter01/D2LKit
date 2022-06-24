//
//  File.swift
//  
//
//  Created by Wouter Hennen on 23/06/2022.
//

import Foundation

extension String {
    func firstCharLowercased() -> String {
        prefix(1).lowercased() + dropFirst()
    }
}
