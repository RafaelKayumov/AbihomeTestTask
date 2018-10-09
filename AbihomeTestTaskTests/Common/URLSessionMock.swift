//
//  URLSessionMock.swift
//  AbihomeTestTaskTests
//
//  Created by Rafael Kayumov on 09.10.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserved.
//

import Foundation

class URLSessionMock: URLSession {

    var data: Data?
    var error: Error?

    override func dataTask ( with request: URLRequest, completionHandler: @escaping NetworkingTransport.DataTaskCompletion) -> URLSessionDataTask {
        let data = self.data
        let error = self.error

        return URLSessionDataTaskMock {
            completionHandler(data, nil, error)
        }
    }
}
