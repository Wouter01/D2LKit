////
//  D2LUrls.swift
//  Hyperion
//
//  Created by Wouter Hennen on 23/01/2021.
//
//  Copyright © 2020 Wouter Hennen
//  Licensed under the Apache License, Version 2.0
//

import Foundation

public typealias PagedAPIData<A: Codable> = Result<PagedResultSet<A>, APIError>
public typealias APIData<A: Codable> = Result<A, APIError>

