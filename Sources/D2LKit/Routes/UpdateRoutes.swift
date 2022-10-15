//
//  File.swift
//  
//
//  Created by Wouter Hennen on 14/10/2022.
//

import Foundation

extension APIRoutes {
    enum UpdateRoute: APIRoute {
        case update

        var platform: Service { .le }

        var url: URLComponents {
            switch self {
            case .update:
                return .init(path: "updates/myUpdates/?orgUnitIdsCSV=633483,633715,635436")
            }
        }
    }
}
