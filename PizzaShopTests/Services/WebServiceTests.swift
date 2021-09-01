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
        // New data will get deleted in the server, so there is no need to cleanup
    }
    
    func testGetAllFoods() throws {
        var foods: [Food] = []
        let foodsExpectation = expectation(description: "Fetch all foods from server")
        WebService().getAllFoods { result in
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
        wait(for: [foodsExpectation], timeout: 15)
        XCTAssertEqual(foods[0].name, "BBQ Chicken Pizza")
    }
    
    func testSubmitOrder() throws {
        var responseCode: Int = 0
        let orderExpectation = expectation(description: "Send order to server")
        WebService().submitOrder(order: Order(name: "Example Name", phone: "09301231122", address: "example address", items: ["example 1"], totalPrice: 10.99), completion: { result in
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
        wait(for: [orderExpectation], timeout: 15)
        XCTAssertEqual(responseCode, 200)
    }
    
}


