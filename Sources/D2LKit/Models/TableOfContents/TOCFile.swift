//
//  File.swift
//  
//
//  Created by Wouter Hennen on 01/09/2022.
//

import Foundation

/// A type which unifies the ``Module`` and ``Topic`` types.
public enum TOCFile: Identifiable, Hashable {

    case description(Comment)
    case module(Module)
    case topic(Topic)
    
    /// The files which are children of the current ``TOCFile``.
    /// For ``topic(_:)``, this variable is always `nil`.
    public var subFiles: [TOCFile]? {
        switch self {
        case .module(let module):
            let files: [TOCFile] = [module.extraInfo?.description]
                .compactMap { $0 }
                .filter { !$0.text.isEmpty }
                .map {
                    TOCFile.description($0)
                } + module.modules.map {
                    TOCFile.module($0)
                } + module.topics.map {
                    TOCFile.topic($0)
                }
            return files.count > 0 ? files : nil
        case .topic(_), .description(_):
            return nil
        }
    }
    
    public var id: Int {
        switch self {
        case .module(let module):
            return module.id
        case .topic(let topic):
            return topic.topicId
        case .description(let desciption):
            return desciption.hashValue
        }
    }
}
