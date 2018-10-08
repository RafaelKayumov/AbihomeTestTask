//
//  ImageSelectorPresenter.swift
//  AbihomeTestTask
//
//  Created by Rafael Kayumov on 08.10.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserved.
//

import UIKit

class ImageSelectorPresenter {

    private let imageService: ImageService
    private unowned var view: ImageSelectorViewInput

    init(imageService: ImageService, view: ImageSelectorViewInput) {
        self.imageService = imageService
        self.view = view
    }
}

extension ImageSelectorPresenter: ImageSelectorViewOutput {
    
}

extension ImageSelectorPresenter: ImageSelectorModuleInput {
    
}
