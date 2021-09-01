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
        UserDefaultsService.shared.removeUserFromUserDefaults()
    }

    func testSaveToUserDefaults() throws {
        UserDefaultsService.shared.saveToUserDefaults(name: "Example Name", phone: "123456789", address: "example address")
        XCTAssertEqual(UserDefaultsService.shared.name, "Example Name")
        XCTAssertEqual(UserDefaultsService.shared.phone, "123456789")
        XCTAssertEqual(UserDefaultsService.shared.address, "example address")
    }

    func testRemoveUserFromUserDefaults() {
        UserDefaultsService.shared.removeUserFromUserDefaults()
        XCTAssertEqual(UserDefaultsService.shared.name, "")
        XCTAssertEqual(UserDefaultsService.shared.phone, "")
        XCTAssertEqual(UserDefaultsService.shared.address, "")
    }
}
