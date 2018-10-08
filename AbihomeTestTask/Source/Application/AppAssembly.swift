//
//  AppAssembly.swift
//  AbihomeTestTask
//
//  Created by Rafael Kayumov on 08.10.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserved.
//

import UIKit

class AppAssembly {

    private(set) static var imageSelectorModule: ImageSelectorModuleInput?

    static func instantiateImageSelectorModuleAndReturnView() -> UIViewController {
        let imageSelectorEntities = assembleImageSelectorModule()
        imageSelectorModule = imageSelectorEntities.module
        return imageSelectorEntities.view
    }
}

private extension AppAssembly {

    static func assembleImageSelectorModule() -> (module: ImageSelectorModuleInput, view: UIViewController) {
        let imageSelectorView = ImageSelectorViewController.instantiate()
        let imageService = ImageService()
        let imageSelectorPresenter = ImageSelectorPresenter(imageService: imageService, view: imageSelectorView)
        imageSelectorView.output = imageSelectorPresenter

        return (module: imageSelectorPresenter, view: imageSelectorView)
    }
}
