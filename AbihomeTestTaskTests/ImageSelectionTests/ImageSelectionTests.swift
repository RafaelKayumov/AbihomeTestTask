//
//  ImageSelectionTests.swift
//  AbihomeTestTaskTests
//
//  Created by Rafael Kayumov on 09.10.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserved.
//

import XCTest

private let kTestImageSelectionIndexFirst = 1
private let kTestImageSelectionIndexSecond = 3

private let kFirstImageName = "first"
private let kSecondImageName = "second"

private let bundleImageNamesList = [
    "",
    kFirstImageName,
    "",
    kSecondImageName,
    "",
    ""
]

class ImageSelectionTests: XCTestCase {

    func testImageSelection() {
        let bundle = Bundle(for: type(of: self))
        let bundledLinksList = bundleImageNamesList.map { (name) -> String in
            guard name.isEmpty == false else { return name }
            return bundle.url(forResource: name, withExtension: "png")!.absoluteString
        }
        let imageListData = try! JSONEncoder().encode(bundledLinksList)

        let firstImage = UIImage(named: kFirstImageName, in: bundle, compatibleWith: nil)
        let firstImageData = firstImage!.pngData()
        let firstImageBundleURL = bundle.url(forResource: kFirstImageName, withExtension: "png")
        let secondImage = UIImage(named: kSecondImageName, in: bundle, compatibleWith: nil)
        let secondImageData = secondImage!.pngData()
        let secondImageBundleURL = bundle.url(forResource: kSecondImageName, withExtension: "png")

        let session = URLSessionMock()
        session.data[ImageService.Route.list.url.absoluteString] = imageListData
        session.data[firstImageBundleURL!.absoluteString] = firstImageData
        session.data[secondImageBundleURL!.absoluteString] = secondImageData

        let transport = NetworkingTransport(session: session)
        let service = ImageService(transport: transport)

        let viewInputMock = ImageSelectorViewInputMock()

        let imageSelectorPresenter = ImageSelectorPresenter(imageService: service, view: viewInputMock)
        imageSelectorPresenter.onTriggerReload()

        let selectionOrderExpectation = XCTestExpectation(description: "selection order expectation")

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            imageSelectorPresenter.onImageSelectWithIndex(kTestImageSelectionIndexFirst)
            XCTAssertEqual(firstImageData, viewInputMock.currentSelectedImage!.pngData())

            imageSelectorPresenter.onImageSelectWithIndex(kTestImageSelectionIndexSecond)
            XCTAssertEqual(firstImageData, viewInputMock.previousSelectedImage?.pngData())
            XCTAssertEqual(secondImageData, viewInputMock.currentSelectedImage?.pngData())

            selectionOrderExpectation.fulfill()
        }

        wait(for: [selectionOrderExpectation], timeout: 5)
    }
}
