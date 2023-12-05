//
//  StubURLSession.swift
//  UrlSessionUnitTestSample
//
//  Created by YD on 12/5/23.
//

import Foundation

struct StubURLSession: URLSessionProtocol {
    var dummyData: DummyData?
    
    init(dummy: DummyData) {
        self.dummyData = dummy
    }

    func dataTask(with url: URL, completionHandler: @escaping DataTaskCompletionHandler) -> URLSessionDataTask {
        return StubURLSessionDataTask(dummy: dummyData, completionHandler: completionHandler)
    }
}
