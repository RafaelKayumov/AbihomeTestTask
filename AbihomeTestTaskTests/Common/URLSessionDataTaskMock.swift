//
//  URLSessionDataTaskMock.swift
//  AbihomeTestTaskTests
//
//  Created by Rafael Kayumov on 09.10.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserved.
//

import Foundation

class URLSessionDataTaskMock: URLSessionDataTask {

    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}
