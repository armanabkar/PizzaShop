//
//  UserDefaultsServiceTests.swift
//  PizzaShopTests
//
//  Created by Arman Abkar on 8/31/21.
//

import XCTest
@testable import PizzaShop

class UserDefaultsServiceTests: XCTestCase {
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
        UserDefaultsService.shared.removeUser()
    }
    
    func test_saveUser() throws {
        let newUser = User(name: "Example Name",
                           phone: "123456789",
                           address: "example address")
        UserDefaultsService.shared.saveUser(user: newUser)
        
        XCTAssertEqual(UserDefaultsService.shared.name, newUser.name)
        XCTAssertEqual(UserDefaultsService.shared.phone, newUser.phone)
        XCTAssertEqual(UserDefaultsService.shared.address, newUser.address)
    }
    
    func test_removeUser() {
        UserDefaultsService.shared.removeUser()
        
        XCTAssertEqual(UserDefaultsService.shared.name, "")
        XCTAssertEqual(UserDefaultsService.shared.phone, "")
        XCTAssertEqual(UserDefaultsService.shared.address, "")
    }
}
