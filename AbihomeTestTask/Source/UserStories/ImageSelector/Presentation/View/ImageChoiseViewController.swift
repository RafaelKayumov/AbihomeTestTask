//
//  ImageChoiseViewController.swift
//  AbihomeTestTask
//
//  Created by Rafael Kayumov on 08.10.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserved.
//

import UIKit

enum ImageChoise {
    case current
    case previous
}

class ImageChoiseViewController: UIViewController, StoryboardBased {

    var imageChoiseType = ImageChoise.current

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
