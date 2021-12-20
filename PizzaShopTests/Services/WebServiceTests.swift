//
//  WebServiceTests.swift
//  PizzaShopTests
//
//  Created by Arman Abkar on 8/31/21.
//

import XCTest
@testable import PizzaShop

class WebServiceTests: XCTestCase {
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
    }
    
    func test_start() async throws {
        let responseCode = try await WebService.shared.start()
        XCTAssertEqual(responseCode, 200)
    }
    
    func test_getAllFoods() async throws {
        let foods: [Food] = try await WebService.shared.getAllFoods()
        XCTAssertEqual(foods[0].name, "BBQ Chicken Pizza")
    }
    
    func test_submitOrder() async throws {
        let newOrder = Order(name: "Example Name", phone: "09301231122", address: "example address", items: ["example 1"], totalPrice: 10.99)
        let responseCode = try await WebService.shared.submitOrder(order: newOrder)
        XCTAssertEqual(responseCode, 200)
    }
    
    func test_submitReservation() async throws {
        let newReservation = Reservation(name: "Example Name", phone: "123456789", tableSize: "Medium", time: "2021-09-07 12:52", request: "Example Request")
        let responseCode = try await WebService.shared.submitReservation(reservation: newReservation)
        XCTAssertEqual(responseCode, 200)
    }
    
    func test_login() throws {
        var fetchedUser = User(name: "", phone: "", address: "")
        let loginExpectation = expectation(description: "Login")
        WebService.shared.login(phone: User(name: "", phone: "09363860000", address: "")) { result in
            switch result {
                case .success(let user):
                    if let user = user {
                        fetchedUser = user
                        loginExpectation.fulfill()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    loginExpectation.fulfill()
            }
        }
        wait(for: [loginExpectation], timeout: 10)
        XCTAssertEqual(fetchedUser.name, "Arman Abkar")
    }
    
    func test_register() throws {
        let randomPhoneNumber = Int.random(in: 1 ... 1000)
        let newUser = User(name: "Example Name", phone: "\(randomPhoneNumber)", address: "Example Address")
        var fetchedUser = User(name: "", phone: "", address: "")
        let registerExpectation = expectation(description: "Register")
        WebService.shared.register(user: newUser) { result in
            switch result {
                case .success(let user):
                    if let user = user {
                        fetchedUser = user
                        registerExpectation.fulfill()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    registerExpectation.fulfill()
            }
        }
        
        wait(for: [registerExpectation], timeout: 10)
        XCTAssertEqual(fetchedUser.name, newUser.name)
    }
    
}


