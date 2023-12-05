//
//  StubURLSessionDataTask.swift
//  UrlSessionUnitTestSample
//
//  Created by YD on 12/5/23.
//

import Foundation

class StubURLSessionDataTask: URLSessionDataTask {
    var dummyData: DummyData?
    
    init(dummy: DummyData?, completionHandler: DataTaskCompletionHandler?) {
        self.dummyData = dummy
        self.dummyData?.completionHandler = completionHandler
    }
    
    override func resume() {
        dummyData?.completion()
    }
}
