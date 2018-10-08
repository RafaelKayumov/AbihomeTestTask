//
//  ImageCell.swift
//  AbihomeTestTask
//
//  Created by Rafael Kayumov on 08.10.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!

    var image: UIImage? {
        get {
            return imageView.image
        } set {
            imageView.image = newValue
        }
    }
}
