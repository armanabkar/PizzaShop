//
//  LoginViewControllerTests.swift
//  PizzaShopTests
//
//  Created by Arman Abkar on 10/22/21.
//

import XCTest
@testable import PizzaShop

class LoginViewControllerTests: XCTestCase {

    func test_CanInit() throws {
        _ = try makeSUT()
    }
    
    func test_viewDidLoad_configuresPhoneField() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.phoneField.delegate, "delegate")
    }
    
    func test_loginUser() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        sut.loginUser()
        XCTAssertNotNil(UserDefaultsService.shared.name)
        XCTAssertNotNil(UserDefaultsService.shared.phone)
        XCTAssertNotNil(UserDefaultsService.shared.address)
    }

    private func makeSUT() throws -> LoginViewController {
        let bundle = Bundle(for: LoginViewController.self)
        let sb = UIStoryboard(name: "Auth", bundle: bundle)
        
        let initialVC = sb.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        initialVC.webService = WebServiceStub()
        return try XCTUnwrap(initialVC)
    }
    
}
