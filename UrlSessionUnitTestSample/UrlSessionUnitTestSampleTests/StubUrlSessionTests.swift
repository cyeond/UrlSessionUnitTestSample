//
//  StubUrlSessionTests.swift
//  UrlSessionUnitTestSampleTests
//
//  Created by YD on 12/5/23.
//

import XCTest
@testable import UrlSessionUnitTestSample

final class StubUrlSessionTests: XCTestCase {
    var sut: API!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = API()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_getData호출시_urlString이빈값이면_invalidUrl에러를반환하는지() {
        // given
        let promise = expectation(description: "getData호출시_urlString이빈값이면_invalidUrl에러를반환하는지")
        let url = URL(string: sut.urlString)!
        sut.urlString = ""
        let dummy = DummyData(data: try! JSONEncoder().encode([["title":"dummy data"]]),
                              response: HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil),
                              error: nil)
        
        sut.urlSession = StubURLSession(dummy: dummy)
        
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
        
        wait(for: [promise], timeout: 10)
    }
    
    func test_getData호출시_error가nil이아니면_urlSessionError을반환하는지() {
        // given
        enum SomeError: Error {
            case someError
        }
        let promise = expectation(description: "getData호출시_error가nil이아니면_urlSessionError을반환하는지")
        let url = URL(string: sut.urlString)!
        let dummy = DummyData(data: try! JSONEncoder().encode([["title":"dummy data"]]),
                              response: HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil),
                              error: SomeError.someError)
        
        sut.urlSession = StubURLSession(dummy: dummy)
        
        // when
        sut.getData { data, error in
            // then
            switch error {
            case .urlSessionError(_):
                XCTAssert(true)
            default:
                XCTAssert(false)
            }
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 10)
    }
    
    func test_getData호출시_response가nil이면_emptyResponse에러를반환하는지() {
        // given
        let promise = expectation(description: "getData호출시_response가nil이면_emptyResponse에러를반환하는지")
        let url = URL(string: sut.urlString)!
        let dummy = DummyData(data: try! JSONEncoder().encode([["title":"dummy data"]]),
                              response: nil,
                              error: nil)
        
        sut.urlSession = StubURLSession(dummy: dummy)
        
        // when
        sut.getData { data, error in
            // then
            switch error {
            case .emptyResponse:
                XCTAssert(true)
            default:
                XCTAssert(false)
            }
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 10)
    }
    
    func test_getData호출시_response의statusCode가300이면_responseStatusCodeError에러를반환하는지() {
        // given
        let promise = expectation(description: "getData호출시_response의statusCode가300이면_responseStatusCodeError에러를반환하는지")
        let url = URL(string: sut.urlString)!
        let dummy = DummyData(data: try! JSONEncoder().encode([["title":"dummy data"]]),
                              response: HTTPURLResponse(url: url, statusCode: 300, httpVersion: nil, headerFields: nil),
                              error: nil)
        
        sut.urlSession = StubURLSession(dummy: dummy)
        
        // when
        sut.getData { data, error in
            // then
            switch error {
            case .responseStatusCodeError(_):
                XCTAssert(true)
            default:
                XCTAssert(false)
            }
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 10)
    }
    
    func test_getData호출시_반환데이터가nil이면_emptyData에러를반환하는지() {
        // given
        let promise = expectation(description: "test_getData호출시_반환데이터가nil이면_emptyData에러를반환하는지")
        let url = URL(string: sut.urlString)!
        let dummy = DummyData(data: nil,
                              response: HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil),
                              error: nil)
        
        sut.urlSession = StubURLSession(dummy: dummy)
        
        // when
        sut.getData { data, error in
            // then
            switch error {
            case .emptyData:
                XCTAssert(true)
            default:
                XCTAssert(false)
            }
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 10)
    }
    
    func test_getData호출시_반환데이터의key값이APIData의포맷과다르면_dataDecodingError에러를반환하는지() {
        // given
        let promise = expectation(description: "getData호출시_반환데이터의key값이APIData의포맷과다르면_dataDecodingError에러를반환하는지")
        let url = URL(string: sut.urlString)!
        let dummy = DummyData(data: try! JSONEncoder().encode([["fake":"dummy data"]]),
                              response: HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil),
                              error: nil)
        
        sut.urlSession = StubURLSession(dummy: dummy)
        
        // when
        sut.getData { data, error in
            // then
            switch error {
            case .dataDecodingError(_):
                XCTAssert(true)
            default:
                XCTAssert(false)
            }
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 10)
    }
    
    func test_getData호출시_반환데이터의value값이APIData의포맷과다르면_dataDecodingError에러를반환하는지() {
        // given
        let promise = expectation(description: "getData호출시_반환데이터의value값이APIData의포맷과다르면_dataDecodingError에러를반환하는지")
        let url = URL(string: sut.urlString)!
        let dummy = DummyData(data: try! JSONEncoder().encode([["title":100]]),
                              response: HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil),
                              error: nil)
        
        sut.urlSession = StubURLSession(dummy: dummy)
        
        // when
        sut.getData { data, error in
            // then
            switch error {
            case .dataDecodingError(_):
                XCTAssert(true)
            default:
                XCTAssert(false)
            }
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 10)
    }
}
