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
    
    func test_viewDidLoad_configuresTextField() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.nameField.delegate, "nameField")
        XCTAssertNotNil(sut.phoneField.delegate, "phoneField")
        XCTAssertNotNil(sut.addressField.delegate, "addressField")
    }


    private func makeSUT() throws -> RegisterViewController {
        let bundle = Bundle(for: RegisterViewController.self)
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        
        let initialVC = sb.instantiateInitialViewController() as! RegisterViewController
        initialVC.webService = WebServiceStub()
        return try XCTUnwrap(initialVC)
    }

}

private class WebServiceStub: API {
    func getAllFoods(completion: @escaping (Result<[Food]?, NetworkError>) -> Void) {}
    func submitOrder(order: Order, completion: @escaping (Result<Int?, NetworkError>) -> Void) {}
    func submitReservation(reservation: Reservation, completion: @escaping (Result<Int?, NetworkError>) -> Void) {}
    func login(phone: User, completion: @escaping (Result<User?, NetworkError>) -> Void) {}
    func register(user: User, completion: @escaping (Result<User?, NetworkError>) -> Void) {}
}
