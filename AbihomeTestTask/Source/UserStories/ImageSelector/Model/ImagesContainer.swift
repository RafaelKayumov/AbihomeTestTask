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

        guard imageLinkFromHistoryWithPosition(.current) != link else { return }

        imageSelectionHistory.append(link)
        imageSelectionHistory = Array(imageSelectionHistory.suffix(2))
    }

    func imageLinkFromHistoryWithPosition(_ position: ImageHistoryPosition) -> String? {
        switch position {
        case .current:
            return imageSelectionHistory.last
        case .previous:
            return imageSelectionHistory.penultimate
        }
    }

    func imageFromHistoryWithPosition(_ position: ImageHistoryPosition) -> UIImage? {
        guard let linkValid = imageLinkFromHistoryWithPosition(position) else { return nil }
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
