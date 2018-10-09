//
//  ImageSelectorViewInputMock.swift
//  AbihomeTestTaskTests
//
//  Created by Rafael Kayumov on 09.10.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserved.
//

import UIKit

class ImageSelectorViewInputMock: ImageSelectorViewInput {

    private(set) var currentSelectedImage: UIImage?
    private(set) var previousSelectedImage: UIImage?

    func displayLoadingIsInProgress(_ inProgress: Bool) {

    }

    func displayImages() {

    }

    func selectCurrentImageWithIndexInGrid(_ index: Int) {

    }

    func setupTabsWithCurrentSelectedImage(_ currentImage: UIImage?, previousImage: UIImage?) {
        currentSelectedImage = currentImage
        previousSelectedImage = previousImage
    }
}
