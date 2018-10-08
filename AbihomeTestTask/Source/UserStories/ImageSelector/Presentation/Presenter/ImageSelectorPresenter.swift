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
                self.view.displayImages()
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

extension ImageSelectorPresenter: ImageSelectorViewDataProvider {

    func imageForIndex(_ index: Int) -> UIImage? {
        guard imagesContainer.imageLinks.indices.contains(index) else { return nil }
        let link = imagesContainer.imageLinks[index]
        return imagesContainer[link]
    }

    var imagesCount: Int {
        return imagesContainer.imageLinks.count
    }
}

extension ImageSelectorPresenter: ImageSelectorViewOutput {

    func onViewReady() {
        loadList()
    }

    func onTriggerReload() {
        loadList()
    }
}

extension ImageSelectorPresenter: ImageSelectorModuleInput {
    
}
