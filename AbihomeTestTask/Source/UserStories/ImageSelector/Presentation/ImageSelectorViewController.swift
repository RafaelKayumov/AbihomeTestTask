//
//  ImageSelectorViewController.swift
//  AbihomeTestTask
//
//  Created by Rafael Kayumov on 08.10.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserved.
//

import UIKit

class ImageSelectorViewController: UIViewController, StoryboardBased {

    weak var output: ImageSelectorViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()

        output?.onViewReady()
    }
}

extension ImageSelectorViewController: ImageSelectorViewInput {

    func displayLoadingIsInProgress(_ inProgress: Bool) {
        
    }
}
