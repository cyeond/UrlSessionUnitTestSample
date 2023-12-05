//
//  DummyData.swift
//  UrlSessionUnitTestSample
//
//  Created by YD on 12/5/23.
//

import Foundation

struct DummyData {
    let data: Data?
    let response: URLResponse?
    let error: Error?
    var completionHandler: DataTaskCompletionHandler? = nil
    
    func completion() {
        completionHandler?(data, response, error)
    }
}
