//
//  ProfileViewControllerTests.swift
//  PizzaShopTests
//
//  Created by Arman Abkar on 10/22/21.
//

import XCTest
@testable import PizzaShop

class ProfileViewControllerTests: XCTestCase {

    let testUser = User(name: "test_name", phone: "123456789", address: "test_address")

    override func setUpWithError() throws {
        UserDefaultsService.shared.saveToUserDefaults(user: testUser)
    }

    override func tearDownWithError() throws {
        UserDefaultsService.shared.removeUserFromUserDefaults()
    }

    func test_CanInit() throws {
        _ = try makeSUT()
    }

    func test_viewDidLoad() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()

        XCTAssertEqual(sut.nameLabel.text, testUser.name)
        XCTAssertEqual(sut.phoneLabel.text, testUser.phone)
        XCTAssertEqual(sut.addressLabel.text, testUser.address)
        XCTAssertEqual(sut.appVersionLabel.text, getAppVersion())
    }

    private func getAppVersion() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary[K.CFBundleShortVersionString] as! String
        let build = dictionary[K.CFBundleVersion] as! String
        return "Version \(version)(\(build))"
    }

    private func makeSUT() throws -> ProfileViewController {
        let bundle = Bundle(for: ProfileViewController.self)
        let sb = UIStoryboard(name: "Main", bundle: bundle)

        let initialVC = sb.instantiateViewController(identifier: "ProfileViewController") as! ProfileViewController
        return try XCTUnwrap(initialVC)
    }

}
