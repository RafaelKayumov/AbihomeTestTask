//
//  ImageService.swift
//  AbihomeTestTask
//
//  Created by Rafael Kayumov on 08.10.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserved.
//

import UIKit

class ImageService {

    typealias ImageListLoadingCompletion = ([String]?, Error?) -> Void
    typealias ImageLoadingCompletion = (UIImage?, Error?) -> Void

    private(set) var transport = NetworkingTransport()

    func fetchImageListWithCompletion(_ completion: @escaping ImageListLoadingCompletion) {
        transport.query(Route.list) { (data, response, error) in
            guard error == nil,
                let data = data,
                let imageURLStrings = try? JSONDecoder().decode([String].self, from: data) else {
                completion(nil, error)
                return
            }

            completion(imageURLStrings, nil)
        }
    }

    func fetchImageWithURL(_ url: URL, completion: @escaping ImageLoadingCompletion) {
        transport.fetchDataWithURL(url) { (data, response, error) in
            guard error == nil,
                let data = data,
                let image = UIImage(data: data) else {
                    completion(nil, error)
                    return
            }

            completion(image, nil)
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
