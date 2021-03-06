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
    typealias ImagesByURLSLoadingCompletion = ([String: UIImage]) -> Void

    private let transport: NetworkingTransport
    init(transport: NetworkingTransport = NetworkingTransport()) {
        self.transport = transport
    }

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

    func fetchImagesForUrls(_ imageUrls: [URL], with completion: @escaping ([String: UIImage]) -> Void) {
        let fetchGroup = DispatchGroup()
        var result = [String: UIImage]()

        imageUrls.forEach { url in
            fetchGroup.enter()

            fetchImageWithURL(url) { image, error in
                defer {
                    fetchGroup.leave()
                }

                guard let image = image, error == nil else { return }
                result[url.absoluteString] = image
            }
        }

        fetchGroup.notify(queue: DispatchQueue.main) {
            completion(result)
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
