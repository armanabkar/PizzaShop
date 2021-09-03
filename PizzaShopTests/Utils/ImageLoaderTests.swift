//
//  ImageLoaderTests.swift
//  PizzaShopTests
//
//  Created by Arman Abkar on 9/2/21.
//

import XCTest
@testable import PizzaShop

class ImageLoaderTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testImageForUrl() throws {
        var exampleImage: UIImage = UIImage()
        let imageExpectation = expectation(description: "Load image asynchronously")
        ImageLoader.sharedInstance.imageForUrl(urlString: "https://pizzashop-server.herokuapp.com/images/bbq_chicken.jpg") { (image, url) in
            if let image = image {
                exampleImage = image
                imageExpectation.fulfill()
            }
        }
        wait(for: [imageExpectation], timeout: 10)
        XCTAssertEqual(exampleImage.pngData()?.count, 779892)
    }

}
