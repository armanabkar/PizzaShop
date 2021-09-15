//
//  PizzaShopUITests.swift
//  PizzaShopUITests
//
//  Created by Arman Abkar on 8/26/21.
//

import XCTest
@testable import PizzaShop

class PizzaShopUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        app.launch()
    }
    
    override func tearDownWithError() throws {
    }
    
    func test_Register() throws {
        if app.tabBars["Tab Bar"].exists {
            app.tabBars["Tab Bar"].buttons["Profile"].tap()
            app.buttons["Log out"].tap()
        }
        let nameField = app.textFields["Enter Your Name"]
        nameField.tap()
        nameField.typeText("Someone Special")
        let phoneField = app.textFields["Enter Your Phone Number"]
        phoneField.tap()
        phoneField.typeText("09131112222")
        let addressField = app.textFields["Enter Your Address"]
        addressField.tap()
        addressField.typeText("Some Example Address 21222, CA")
        app.buttons["Return"].tap()
        app.staticTexts["Register"].tap()
    }
    
    func test_OrderFood() throws {
        let foodItem = app.tables.staticTexts["Hawaiian Pizza"]
        XCTAssertTrue(foodItem.waitForExistence(timeout: 10))
        sleep(1)
        foodItem.tap()
        app.staticTexts["Add to Cart"].tap()
        app.alerts["Cart"].scrollViews.otherElements.buttons["OK"].tap()
        app.swipeDown(velocity: XCUIGestureVelocity.fast)
        app.tabBars["Tab Bar"].buttons["Cart"].tap()
        app.buttons["Submit Order"].tap()
        app.alerts["Thank You"].scrollViews.otherElements.buttons["OK"].tap()
    }
    
    func test_LogOut() throws {
        app.tabBars["Tab Bar"].buttons["Profile"].tap()
        app.buttons["Log out"].tap()
        app.terminate()
    }
    
    func test_Login() throws {
        app.staticTexts["Already have an account?"].tap()
        app.staticTexts["Login"].tap()
        app.tabBars["Tab Bar"].buttons["Profile"].tap()
        app.staticTexts["Log out"].tap()
        app.terminate()
    }
    
    func testLaunchPerformance() throws {
                if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
