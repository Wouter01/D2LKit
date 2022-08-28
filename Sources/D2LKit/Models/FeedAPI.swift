////
//  File.swift
//  Ufora
//
//  Created by Wouter Hennen on 02/02/2021.
//
//  Copyright © 2020 Wouter Hennen
//  Licensed under the Apache License, Version 2.0
//

import Foundation

public struct UserFeedResource: Codable {
    let type: String,
        metadata: MessageMetaData,
        resource: News
    struct MessageMetaData: Codable {
        let identifier: String,
            title: String,
            summary: Comment,
            date: String,
            apiViewUrl: String,
            webViewUrl: String
    }
}
