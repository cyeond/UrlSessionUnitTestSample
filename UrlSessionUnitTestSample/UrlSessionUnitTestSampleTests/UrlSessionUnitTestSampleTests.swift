//
//  UrlSessionUnitTestSampleTests.swift
//  UrlSessionUnitTestSampleTests
//
//  Created by YD on 12/5/23.
//

import XCTest
@testable import UrlSessionUnitTestSample

final class UrlSessionUnitTestSampleTests: XCTestCase {
    var sut: API!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = API()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_getData호출시_에러가_nil인지() {
        // given
        let promise = expectation(description: "getData호출시_에러가_nil인지")
        
        // when
        sut.getData {
            // then
            XCTAssertNil($1)
            
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 10.0)
    }
    
    func test_getData호출시_획득한데이터의개수가_100개인지() {
        // given
        let promise = expectation(description: "getData호출시_획득한데이터의개수가_100개인지")
        
        // when
        sut.getData { data, error in
            // then
            XCTAssertEqual(data?.count, 100)
            
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 10.0)
    }
    
    func test_getData호출시_획득한데이터의모든값들이_빈값이아닌title을가지고있는지() {
        // given
        let promise = expectation(description: "getData호출시_획득한데이터의모든값들이_빈값이아닌title을가지고있는지")
        
        // when
        sut.getData { data, error in
            // then
            let existingDataCount = data?.filter { $0.title.count > 0 }.count
            XCTAssertEqual(existingDataCount, data?.count)
            
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 10.0)
    }
    
    func test_getData호출시_urlString이빈값이면_invalidUrl에러를반환하는지() {
        // given
        let promise = expectation(description: "getData호출시_urlString이빈값이면_invalidUrl에러를반환하는지")
        sut.urlString = ""
        
        // when
        sut.getData { data, error in
            // then
            switch error {
            case .invalidUrl:
                XCTAssert(true)
            default:
                XCTAssert(false)
            }
            
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 10.0)
    }
}
