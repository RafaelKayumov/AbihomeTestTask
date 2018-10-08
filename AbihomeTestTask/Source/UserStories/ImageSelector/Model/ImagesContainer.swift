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

    private(set) var imageLinks = [String]()
    private(set) var imageCache = NSCache<NSString, UIImage>()

    private(set) var imageSelectionHistory: [String] = {
        var array = [String]()
        array.reserveCapacity(kImageSelectionHistoryCapacity)
        return array
    }()
}
