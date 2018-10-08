//
//  ImageSelectorViewController.swift
//  AbihomeTestTask
//
//  Created by Rafael Kayumov on 08.10.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserved.
//

import UIKit

private let kImageGridEmbedSegue = "ImageGridEmbedSegue"

class ImageSelectorViewController: UITabBarController, StoryboardBased {

    weak var output: ImageSelectorViewOutput!
    weak var viewDataProvider: ImageSelectorViewDataProvider!

    var imageGridViewController: ImageGridViewController!
    var currentSelectedImageViewController: ImageChoiseViewController!
    var previousSelectedImageViewController: ImageChoiseViewController!

    private func assembleTabs() {
        let imageGridViewController = ImageGridViewController.instantiate()
        imageGridViewController.title = "Images"
        imageGridViewController.dataProvider = self
        imageGridViewController.responder = self

        let currentSelectedImageViewController = ImageChoiseViewController.instantiate()
        currentSelectedImageViewController.title = "Current Selection"
        currentSelectedImageViewController.imageChoiseType = .current

        let previousSelectedImageViewController = ImageChoiseViewController.instantiate()
        previousSelectedImageViewController.title = "Previous Selection"
        previousSelectedImageViewController.imageChoiseType = .previous

        viewControllers = [imageGridViewController, currentSelectedImageViewController, previousSelectedImageViewController]

        self.imageGridViewController = imageGridViewController
        self.currentSelectedImageViewController = currentSelectedImageViewController
        self.previousSelectedImageViewController = previousSelectedImageViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        assembleTabs()

        output?.onViewReady()
    }
}

extension ImageSelectorViewController: ImageGridViewDataProvider {

    func imageForIndex(_ index: Int) -> UIImage? {
        return viewDataProvider!.imageForIndex(index)
    }

    var imagesCount: Int {
        return viewDataProvider!.imagesCount
    }
}

extension ImageSelectorViewController: ImageGridViewResponder {

    func onRefresh() {
        output.onTriggerReload()
    }
}

extension ImageSelectorViewController: ImageSelectorViewInput {

    func displayImages() {
        imageGridViewController.displayImages()
    }

    func displayLoadingIsInProgress(_ inProgress: Bool) {
        imageGridViewController.displayLoadingIsInProgress(inProgress)
    }
}


