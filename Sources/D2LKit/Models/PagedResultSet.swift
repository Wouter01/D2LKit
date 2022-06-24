//
//  File.swift
//  
//
//  Created by Wouter Hennen on 24/06/2022.
//

import Foundation

public struct PagedResultSet<T: Codable>: Codable {
    public let pagingInfo: PagingInfo,
               items: [T]
    public struct PagingInfo: Codable {
        public let bookmark: String,
                   hasMoreItems: Bool
    }
}
