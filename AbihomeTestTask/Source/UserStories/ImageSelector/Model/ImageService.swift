//
//  ImageService.swift
//  AbihomeTestTask
//
//  Created by Rafael Kayumov on 08.10.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserved.
//

import Foundation

class ImageService {

    typealias ImageListLoadingCompletion = ([String]?, Error?) -> Void

    func fetchImageListWithCompletion(_ completion: @escaping ImageListLoadingCompletion) {
        Networking.query(Route.list) { (data, response, error) in
            guard error == nil,
                let data = data,
                let imageURLStrings = try? JSONDecoder().decode([String].self, from: data) else {
                completion(nil, error)
                return
            }

            completion(imageURLStrings, nil)
        }
    }
}

private let kImageServiceBaseURLString = "http://weyveed.herokuapp.com/"
private let kImageServiceListPath = "test/images/"

extension ImageService {

    enum Route: RouteProviding {

        case list

        private static let baseUrl = URL(string: kImageServiceBaseURLString)!

        var path: String {
            switch self {
            case .list:
                return "test/images/"
            }
        }

        var url: URL {
            switch self {
            case .list:
                return Route.baseUrl.appendingPathComponent(self.path)
            }
        }
    }
}
