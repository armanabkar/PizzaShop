//
//  MainViewControllerTests.swift
//  PizzaShopTests
//
//  Created by Arman Abkar on 10/22/21.
//

import XCTest
import MapKit
@testable import PizzaShop

class MainViewControllerTests: XCTestCase {

    func test_CanInit() throws {
        _ = try makeSUT()
    }

    private func makeSUT() throws -> MainViewController {
        let bundle = Bundle(for: MainViewController.self)
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        
        let initialVC = sb.instantiateViewController(identifier: "MainViewController") as! MainViewController
        return try XCTUnwrap(initialVC)
    }
    
}
