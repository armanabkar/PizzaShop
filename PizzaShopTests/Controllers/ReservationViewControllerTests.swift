//
//  ReservationViewControllerTests.swift
//  PizzaShopTests
//
//  Created by Arman Abkar on 11/3/21.
//

import XCTest
@testable import PizzaShop

class ReservationViewControllerTests: XCTestCase {

    let testUser = User(name: "test_name", phone: "123456789", address: "test_address")
    
    override func setUpWithError() throws {
        UserDefaultsService.shared.saveUser(user: testUser)
    }

    override func tearDownWithError() throws {
        UserDefaultsService.shared.removeUser()
    }

    func test_viewDidLoad_nameLabel() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.nameLabel.text, "Dear \(testUser.name),")
    }

    private func makeSUT() throws -> ReservationViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: ReservationViewController = storyboard.instantiateViewController(withIdentifier: "ReservationViewController") as! ReservationViewController
        XCTAssertNotNil(vc)
        XCTAssertNotNil(vc.view)
        vc.webService = WebServiceStub()
        return vc
    }
}
