//
//  APIError.swift
//  UrlSessionUnitTestSample
//
//  Created by YD on 12/5/23.
//

import Foundation

enum APIError: Error {
    case invalidUrl
    case emptyData
    case emptyResponse
    case urlSessionError(String)
    case dataDecodingError(String)
    case responseStatusCodeError(Int)
}
