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

    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.layer.borderColor = UIColor.blue.cgColor
    }

    var image: UIImage? {
        get {
            return imageView.image
        } set {
            imageView.image = newValue
        }
    }

    override var isSelected: Bool {
        didSet {
            setSelected(isSelected)
        }
    }

    private func setSelected(_ selected: Bool) {
        contentView.layer.borderWidth = selected ? 2 : 0
    }
}
