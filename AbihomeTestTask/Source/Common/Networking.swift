//
//  Networking.swift
//  AbihomeTestTask
//
//  Created by Rafael Kayumov on 08.10.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserved.
//

import Foundation

protocol RouteProviding {
    var url: URL { get }
}

class Networking {

    static func query(_ route: RouteProviding, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var request = URLRequest(url: route.url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }

        task.resume()
    }
}
