//
//  ImageServiceTests.swift
//  AbihomeTestTaskTests
//
//  Created by Rafael Kayumov on 09.10.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserved.
//

import XCTest

private let imageLinksListReference = [
    "https://d30y9cdsu7xlg0.cloudfront.net/png/65350-200.png",
    "https://3.bp.blogspot.com/-g4Vbb9tXU4E/TuX2Cbp78QI/AAAAAAAAAgo/JViA4tQc3Oo/s1600/dd.png",
    "https://www.iconhot.com/icon/png/emoji/200/emoji-6.png",
    "https://screentimelabs.com/wp-content/uploads/2015/09/screen-time-parental-control-689-l-280x280-200x200.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/Circle-icons-phone.svg/200px-Circle-icons-phone.svg.png",
    "https://d30y9cdsu7xlg0.cloudfront.net/png/177723-200.png"
]

class ImageServiceTests: XCTestCase {

    func testFetchAndDeserialize() {
        let imagesListBundleURL = Bundle(for: type(of: self)).url(forResource: "ImagesList", withExtension: "json")
        let imageListData = try? Data.init(contentsOf: imagesListBundleURL!)
        let session = URLSessionMock()
        session.data[ImageService.Route.list.url.absoluteString] = imageListData
        let transport = NetworkingTransport(session: session)
        let service = ImageService(transport: transport)

        let fetchAndDeserializeExpectation = XCTestExpectation(description: "Fetch and deserialize image links list")

        service.fetchImageListWithCompletion { linksList, error in
            XCTAssertEqual(linksList, imageLinksListReference)
            fetchAndDeserializeExpectation.fulfill()
        }

        wait(for: [fetchAndDeserializeExpectation], timeout: 5)
    }
}
