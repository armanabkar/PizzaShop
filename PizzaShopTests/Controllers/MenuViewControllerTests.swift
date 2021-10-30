//
//  MenuViewControllerTests.swift
//  PizzaShopTests
//
//  Created by Arman Abkar on 9/11/21.
//

import XCTest
@testable import PizzaShop

class MenuViewControllerTests: XCTestCase {
    
    func testCanInit() throws {
        _ = try makeSUT()
    }
    
    func test_viewDidLoad_configuresTableView() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.tableView.delegate, "delegate")
        XCTAssertNotNil(sut.tableView.dataSource, "data source")
    }
    
    func test_viewDidLoad_initialState() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_viewDidLoad_getAllFoods() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        
        let exp = expectation(description: "Wait for API")
        exp.isInverted = true
        wait(for: [exp], timeout: 2)
        XCTAssertEqual(sut.items.count, 0)
    }
    
    private func makeSUT() throws -> MenuViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: MenuViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        XCTAssertNotNil(vc)
        XCTAssertNotNil(vc.view)
        vc.webService = WebServiceStub()
        return vc
    }

}
