//
//  ImagesContainer.swift
//  AbihomeTestTask
//
//  Created by Rafael Kayumov on 08.10.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserved.
//

import UIKit

private let kImageSelectionHistoryCapacity = 2

class ImagesContainer {

    private(set) var imageCache = NSCache<NSString, UIImage>()

    var imageLinks = [String]() {
        didSet {
            removeMissingFromHistory()
        }
    }

    private(set) var imageSelectionHistory: [String] = {
        var array = [String]()
        array.reserveCapacity(kImageSelectionHistoryCapacity)
        return array
    }()

    private func removeMissingFromHistory() {
        imageSelectionHistory = imageSelectionHistory.filter { imageLinks.contains($0) }
    }
}

extension ImagesContainer {

    subscript(key: String) -> UIImage? {
        get {
            let keyStringObject = NSString(string: key)
            return imageCache.object(forKey: keyStringObject)
        } set {
            let keyStringObject = NSString(string: key)
            if let value = newValue {
                imageCache.setObject(value, forKey: keyStringObject)
            } else {
                imageCache.removeObject(forKey: keyStringObject)
            }
        }
    }
}
