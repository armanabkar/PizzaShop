//
//  RegisterViewControllerTests.swift
//  PizzaShopTests
//
//  Created by Arman Abkar on 9/11/21.
//

import XCTest
@testable import PizzaShop

class RegisterViewControllerTests: XCTestCase {

    func test_CanInit() throws {
        _ = try makeSUT()
    }
    
    func test_viewDidLoad() throws {
        let sut = try makeSUT()
        
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.appTitle.text)
    }
    
    func test_viewDidLoad_configuresTextField() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.nameField.delegate, "nameField")
        XCTAssertNotNil(sut.phoneField.delegate, "phoneField")
        XCTAssertNotNil(sut.addressField.delegate, "addressField")
    }
    
    func test_animateText() throws {
        //let sut = try makeSUT()
        //sut.loadViewIfNeeded()
        //sut.animateText()
        
        //XCTAssertEqual(sut.appTitle.text, K.Information.appName)
    }
    
    func test_registerUser() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        sut.registerUser()
        XCTAssertNotNil(UserDefaultsService.shared.name)
        XCTAssertNotNil(UserDefaultsService.shared.phone)
        XCTAssertNotNil(UserDefaultsService.shared.address)
    }


    private func makeSUT() throws -> RegisterViewController {
        let bundle = Bundle(for: RegisterViewController.self)
        let sb = UIStoryboard(name: "Auth", bundle: bundle)
        
        let initialVC = sb.instantiateInitialViewController() as! RegisterViewController
        initialVC.webService = WebServiceStub()
        return try XCTUnwrap(initialVC)
    }

}
