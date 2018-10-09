//
//  ImageSelectorViewInput.swift
//  AbihomeTestTask
//
//  Created by Rafael Kayumov on 08.10.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserved.
//

import UIKit

protocol ImageSelectorViewInput: AnyObject {

    func displayLoadingIsInProgress(_ inProgress: Bool)
    func displayImages()
    func selectCurrentImageWithIndexInGrid(_ index: Int)
    func setupTabsWithCurrentSelectedImage(_ currentImage: UIImage?, previousImage: UIImage?)
}
