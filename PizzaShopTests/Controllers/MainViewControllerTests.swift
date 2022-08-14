//
//  HomeViewControllerTests.swift
//  PizzaShopTests
//
//  Created by Arman Abkar on 10/22/21.
//

import XCTest
import MapKit
@testable import PizzaShop

class HomeViewControllerTests: XCTestCase {

    func test_CanInit() throws {
        _ = try makeSUT()
    }

    private func makeSUT() throws -> HomeViewController {
        let bundle = Bundle(for: HomeViewController.self)
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        
        let initialVC = sb.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        return try XCTUnwrap(initialVC)
    }
    
}
