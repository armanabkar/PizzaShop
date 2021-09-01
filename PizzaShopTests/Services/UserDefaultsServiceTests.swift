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
        UserDefaultsService.removeUserFromUserDefaults()
    }

    func testSaveToUserDefaults() throws {
        UserDefaultsService.saveToUserDefaults(name: "Example Name", phone: "123456789", address: "example address")
        XCTAssertEqual(UserDefaultsService.name, "Example Name")
        XCTAssertEqual(UserDefaultsService.phone, "123456789")
        XCTAssertEqual(UserDefaultsService.address, "example address")
    }

    func testRemoveUserFromUserDefaults() {
        UserDefaultsService.removeUserFromUserDefaults()
        XCTAssertEqual(UserDefaultsService.name, "")
        XCTAssertEqual(UserDefaultsService.phone, "")
        XCTAssertEqual(UserDefaultsService.address, "")
    }
}
