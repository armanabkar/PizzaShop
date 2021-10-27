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
        
    func test_showRestaurantLocation() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        sut.showRestaurantLocation()
        
        let latitude = 34.40234099999999
        let longitude = -119.726045
        
        XCTAssertEqual(sut.mapView.centerCoordinate.latitude, latitude)
        XCTAssertEqual(sut.mapView.centerCoordinate.longitude, longitude)
    }
    
    private func makeSUT() throws -> MainViewController {
        let bundle = Bundle(for: MainViewController.self)
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        
        let initialVC = sb.instantiateViewController(identifier: "MainViewController") as! MainViewController
        return try XCTUnwrap(initialVC)
    }
    
}
