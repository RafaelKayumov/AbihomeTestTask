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

    private let imagesContainer = ImagesContainer()

    init(imageService: ImageService, view: ImageSelectorViewInput) {
        self.imageService = imageService
        self.view = view
    }
}

private extension ImageSelectorPresenter {

    func loadList() {
        displayLoadingActivityInView(isLoading: true)
        imageService.fetchImageListWithCompletion { imageLinks, _ in
            guard let imageLinks = imageLinks else {
                self.displayLoadingActivityInView(isLoading: false)
                return
            }

            self.applyImageLinksToContainer(imageLinks)
            let urls = imageLinks.compactMap { URL(string: $0) }
            self.imageService.fetchImagesForUrls(urls, with: {
                self.applyImagesToContainer($0)
                self.displayLoadingActivityInView(isLoading: false)
                print(self.imagesContainer["https://d30y9cdsu7xlg0.cloudfront.net/png/177723-200.png"])
            })
        }
    }

    func applyImageLinksToContainer(_ links: [String]) {
        imagesContainer.imageLinks = links
    }

    func applyImagesToContainer(_ dicionary: [String: UIImage]) {
        dicionary.forEach { keyValuePair in
            imagesContainer[keyValuePair.key] = keyValuePair.value
        }
    }

    func displayLoadingActivityInView(isLoading: Bool) {
        DispatchQueue.main.async {
            self.view.displayLoadingIsInProgress(isLoading)
        }
    }
}

extension ImageSelectorPresenter: ImageSelectorViewOutput {

    func onViewReady() {
        loadList()
    }
}

extension ImageSelectorPresenter: ImageSelectorModuleInput {
    
}
