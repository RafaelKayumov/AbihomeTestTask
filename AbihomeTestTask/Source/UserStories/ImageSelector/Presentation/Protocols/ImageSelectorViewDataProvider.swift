//
//  ImageSelectorViewDataProvider.swift
//  AbihomeTestTask
//
//  Created by Rafael Kayumov on 08.10.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserved.
//

import UIKit

protocol ImageSelectorViewDataProvider: AnyObject {

    func imageForIndex(_ index: Int) -> UIImage?
    var imagesCount: Int { get }
}
