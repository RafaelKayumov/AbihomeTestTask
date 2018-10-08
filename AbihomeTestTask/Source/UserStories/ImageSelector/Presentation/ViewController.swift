//
//  ViewController.swift
//  AbihomeTestTask
//
//  Created by Rafael Kayumov on 08.10.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let imageService = ImageService()

        imageService.fetchImageListWithCompletion { (imageLinks, error) in
            imageLinks?.forEach {
                guard let imageURL = URL(string: $0) else { return }
                imageService.fetchImageWithURL(imageURL) { image, _ in
                    print(image)
                }
            }
        }
    }
}
