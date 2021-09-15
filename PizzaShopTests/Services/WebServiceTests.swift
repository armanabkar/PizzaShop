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
    
    func test_getAllFoods() throws {
        var foods: [Food] = []
        let foodsExpectation = expectation(description: "Fetch all foods from server")
        WebService.shared.getAllFoods { result in
            switch result {
                case .success(let fetchedFoods):
                    if let fetchedFoods = fetchedFoods {
                        foods.append(contentsOf: fetchedFoods)
                        foodsExpectation.fulfill()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    foodsExpectation.fulfill()
            }
        }
        wait(for: [foodsExpectation], timeout: 10)
        XCTAssertEqual(foods[0].name, "BBQ Chicken Pizza")
    }
    
    func test_submitOrder() throws {
        var responseCode: Int = 0
        let newOrder = Order(name: "Example Name", phone: "09301231122", address: "example address", items: ["example 1"], totalPrice: 10.99)
        let orderExpectation = expectation(description: "Send order to server")
        WebService.shared.submitOrder(order: newOrder, completion: { result in
            switch result {
                case .success(let statusCode):
                    if let statusCode = statusCode {
                        responseCode = statusCode
                        orderExpectation.fulfill()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    orderExpectation.fulfill()
            }
        })
        wait(for: [orderExpectation], timeout: 10)
        XCTAssertEqual(responseCode, 200)
    }
    
    func test_submitReservation() throws {
        var responseCode: Int = 0
        let newReservation = Reservation(name: "Example Name", phone: "123456789", tableSize: "Medium", time: "2021-09-07 12:52", request: "Example Request")
        let reservationExpectation = expectation(description: "Send reservation to server")
        WebService.shared.submitReservation(reservation: newReservation, completion: { result in
            switch result {
                case .success(let statusCode):
                    if let statusCode = statusCode {
                        responseCode = statusCode
                        reservationExpectation.fulfill()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    reservationExpectation.fulfill()
            }
        })
        wait(for: [reservationExpectation], timeout: 10)
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


