//
//  ImageGridViewController.swift
//  AbihomeTestTask
//
//  Created by Rafael Kayumov on 08.10.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserved.
//

import UIKit

protocol ImageGridViewDataProvider: AnyObject {
    func imageForIndex(_ index: Int) -> UIImage?
    var imagesCount: Int { get }
}

protocol ImageGridViewResponder: AnyObject {
    func onRefresh()
    func onImageSelectWithIndex(_ index: Int)
}

private let kColumntsCount: CGFloat = 3

class ImageGridViewController: UIViewController, StoryboardBased {

    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
            collectionView.refreshControl = refreshControl
            self.refreshControl = refreshControl
        }
    }
    @IBOutlet private weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    private weak var refreshControl: UIRefreshControl!

    weak var dataProvider: ImageGridViewDataProvider!
    weak var responder: ImageGridViewResponder!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureItemSize()
    }

    private func configureItemSize() {
        let itemSide = (min(view.bounds.width, view.bounds.height) - collectionViewFlowLayout.sectionInset.left - collectionViewFlowLayout.sectionInset.right - max(0, kColumntsCount - 1) * collectionViewFlowLayout.minimumLineSpacing) / kColumntsCount
        let itemSize = CGSize(width: itemSide, height: itemSide)
        collectionViewFlowLayout.itemSize = itemSize
        collectionViewFlowLayout.invalidateLayout()
    }

    func displayImages() {
        collectionView.reloadData()
    }

    @objc func onRefresh() {
        responder.onRefresh()
    }

    func displayLoadingIsInProgress(_ inProgress: Bool) {
        if inProgress {
            refreshControl.beginRefreshing()
        } else {
            refreshControl.endRefreshing()
        }
    }

    func selectImageWithIndex(_ index: Int) {
        collectionView.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: UICollectionView.ScrollPosition.top)
    }
}

extension ImageGridViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataProvider.imagesCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageCell.self), for: indexPath)

        if let imageCell = cell as? ImageCell, let image = dataProvider.imageForIndex(indexPath.item) {
            imageCell.image = image
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        responder.onImageSelectWithIndex(indexPath.item)
    }
}
