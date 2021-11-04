//
//  CartViewControllerTests.swift
//  PizzaShopTests
//
//  Created by Arman Abkar on 11/1/21.
//

import XCTest
@testable import PizzaShop

class CartViewControllerTests: XCTestCase {
    
    func testCanInit() throws {
        _ = try makeSUT()
    }
    
    func test_viewDidLoad_configuresTableView() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.tableView.delegate, "delegate")
        XCTAssertNotNil(sut.tableView.dataSource, "data source")
    }
    
    func test_totalPrice() throws {
    }
    
    func test_submitOrder() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        sut.submitOrder()
        
        let exp = expectation(description: "Wait for API")
        exp.isInverted = true
        wait(for: [exp], timeout: 2)
        
        XCTAssertTrue(sut.cartItems.isEmpty)
    }
    
    private func makeSUT() throws -> CartViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: CartViewController = storyboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        XCTAssertNotNil(vc)
        XCTAssertNotNil(vc.view)
        vc.webService = WebServiceStub()
        return vc
    }
    
}
