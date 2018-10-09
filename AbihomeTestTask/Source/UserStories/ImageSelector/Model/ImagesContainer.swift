//
//  ImagesContainer.swift
//  AbihomeTestTask
//
//  Created by Rafael Kayumov on 08.10.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserved.
//

import UIKit

private let kImageSelectionHistoryCapacity = 2

enum ImageHistoryPosition {
    case current
    case previous
}

class ImagesContainer {

    private(set) var imageCache = NSCache<NSString, UIImage>()

    var imageLinks = [String]() {
        didSet {
            removeMissingFromHistory()
        }
    }

    private(set) var imageSelectionHistory = [String]()

    private func removeMissingFromHistory() {
        imageSelectionHistory = imageSelectionHistory.filter { imageLinks.contains($0) }
    }

    func applyImageLinkWithIndexToHistory(index: Int) {
        guard imageLinks.indices.contains(index) else { return }
        let link = imageLinks[index]
        imageSelectionHistory.append(link)
        imageSelectionHistory = Array(imageSelectionHistory.suffix(2))
    }

    func imageFromShistoryWithPosition(_ position: ImageHistoryPosition) -> UIImage? {
        var imageLink: String?
        switch position {
        case .current:
            imageLink = imageSelectionHistory.last
        case .previous:
            imageLink = imageSelectionHistory.penultimate
        }

        guard let linkValid = imageLink else { return nil }
        return self[linkValid]
    }

    var indexOfLastSelectedImage: Int? {
        guard let link = imageSelectionHistory.last else { return nil }
        return imageLinks.firstIndex(of: link)
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
