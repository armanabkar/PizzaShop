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
    
    func test_login() async throws {
        let user = User(name: "", phone: "09363860000", address: "")
        let fetchedUser = try await WebService.shared.login(user: user)
        XCTAssertEqual(fetchedUser.name, "Arman Abkar")
    }
    
    func test_register() async throws {
        let randomPhoneNumber = Int.random(in: 1 ... 1000)
        let newUser = User(name: "Example Name", phone: "\(randomPhoneNumber)", address: "Example Address")
        let fetchedUser = try await WebService.shared.register(user: newUser)
        XCTAssertEqual(fetchedUser.name, newUser.name)
    }
    
}


