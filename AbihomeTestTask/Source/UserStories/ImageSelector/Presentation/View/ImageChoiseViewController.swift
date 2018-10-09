//
//  ImageChoiseViewController.swift
//  AbihomeTestTask
//
//  Created by Rafael Kayumov on 08.10.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserved.
//

import UIKit

class ImageChoiseViewController: UIViewController, StoryboardBased {

    var image: UIImage? {
        didSet {
            displayCurrentImageIfNeeded()
        }
    }

    @IBOutlet private weak var imageView: UIImageView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        displayCurrentImageIfNeeded()
    }

    private func displayCurrentImageIfNeeded() {
        guard isViewLoaded else { return }
        imageView.image = image
    }
}
