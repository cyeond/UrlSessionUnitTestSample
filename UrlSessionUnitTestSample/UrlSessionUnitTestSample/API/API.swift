//
//  API.swift
//  UrlSessionUnitTestSample
//
//  Created by YD on 12/5/23.
//

import Foundation

struct APIData: Codable {
    var title: String
}

struct API {
    var urlString = "https://jsonplaceholder.typicode.com/posts"
    var urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }
    
    init() {
        self.init(urlSession: URLSession.shared)
    }
    
    func getData(completionHandler: @escaping ([APIData]?, APIError?) -> Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(nil, .invalidUrl)
            return
        }
        
        let task = urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                completionHandler(nil, .urlSessionError(error.localizedDescription))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completionHandler(nil, .emptyResponse)
                return
            }
            guard (200..<300) ~= response.statusCode else {
                completionHandler(nil, .responseStatusCodeError(response.statusCode))
                return
            }
            guard let data = data else {
                completionHandler(nil, .emptyData)
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([APIData].self, from: data)
                completionHandler(decodedData, nil)
            } catch {
                completionHandler(nil, .dataDecodingError(error.localizedDescription))
                return
            }
        }
        
        task.resume()
    }
}
