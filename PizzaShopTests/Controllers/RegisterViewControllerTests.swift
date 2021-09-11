//
//  RegisterViewControllerTests.swift
//  PizzaShopTests
//
//  Created by Arman Abkar on 9/11/21.
//

import XCTest
@testable import PizzaShop

class RegisterViewControllerTests: XCTestCase {

    func testCanInit() throws {
        _ = try makeSUT()
    }
    
    func test_viewDidLoad() throws {
        let sut = try makeSUT()
        
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.appTitle?.text, "Pizza Pizza")
    }

    private func makeSUT() throws -> RegisterViewController {
        let bundle = Bundle(for: RegisterViewController.self)
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        
        let initialVC = sb.instantiateInitialViewController()
        return try XCTUnwrap(initialVC) as! RegisterViewController
    }

}
