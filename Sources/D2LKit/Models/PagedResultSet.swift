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



public struct BlockResultSet<T: Codable>: Codable, Searchable {
    
    public var searchTerm: String = ""
    public var next: URL?
    public var objects: [T]
    
    public init(next: URL? = nil, objects: [T]) {
        self.next = next
        self.objects = objects
    }
    
    enum CodingKeys: CodingKey {
        case next
        case objects
    }
}
