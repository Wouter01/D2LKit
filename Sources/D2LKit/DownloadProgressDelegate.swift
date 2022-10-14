//
//  DownloadProgressDelegate.swift
//  Ufora
//
//  Created by Wouter Hennen on 02/09/2022.
//

import Combine
import SwiftUI

public class DownloadProgressDelegate: NSObject, URLSessionTaskDelegate, ObservableObject {
    @Published public var currentAmountOfBytes: Int64 = .zero
    @Published public var totalAmountOfBytes: Int64 = .zero
    
    public func urlSession(_ session: URLSession, didCreateTask task: URLSessionTask) {
        task.publisher(for: \.countOfBytesReceived)
            .throttle(for: .milliseconds(100), scheduler: DispatchQueue.main, latest: true)
            .receive(on: RunLoop.main)
            .assign(to: &$currentAmountOfBytes)
        
        task.publisher(for: \.countOfBytesExpectedToReceive)
            .receive(on: RunLoop.main)
            .assign(to: &$totalAmountOfBytes)
    }
}
