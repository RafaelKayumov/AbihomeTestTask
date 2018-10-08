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

        ImageService().fetchImageListWithCompletion { (imageLinks, error) in
            imageLinks?.forEach {
                print($0)
            }
        }
    }
}
