//
//  CoreDataServiceTests.swift
//  PizzaShopTests
//
//  Created by Arman Abkar on 9/2/21.
//

import XCTest
@testable import PizzaShop

class CoreDataServiceTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        deleteAllItems()
    }

    func testAddToCart() throws {
        var successMessage = ""
        CoreDataService.shared.addToCart(foodName: "Example Food", foodPrice: "9.99") { result in
            switch result {
                case .success(let message):
                    successMessage = message
                case .failure(_):
                    break
            }
        }
        XCTAssertEqual(successMessage, "Saved To Cart")
        deleteAllItems()
    }
    
    func testLoadCartItems() throws {
        var firstItemName = ""
        addNewItem()
        CoreDataService.shared.loadCartItems { result in
            switch result {
                case .success(let items):
                    firstItemName = items[0].name ?? ""
                case .failure(_): break
            }
        }
        XCTAssertEqual(firstItemName, "Example Food")
    }
    
    func testSaveCartItems() throws {
        var successMessage = ""
        CoreDataService.shared.saveCartItems { result in
            switch result {
                case .success(let message):
                    successMessage = message
                case .failure(_): break
            }
        }
        XCTAssertEqual(successMessage, "Saved successfully")
    }
    
    func testResetAllRecords() throws {
        var successMessage = ""
        CoreDataService.shared.resetAllRecords(in: K.CoreData.entityName) { result in
            switch result {
                case .success(let message):
                    successMessage = message
                case .failure(_): break
            }
        }
        XCTAssertEqual(successMessage, "All records deleted")
    }
    
    func addNewItem() {
        CoreDataService.shared.addToCart(foodName: "Example Food", foodPrice: "9.99") { result in
            switch result {
                case .success(_): break
                case .failure(_): break
            }
        }
    }
    
    func deleteAllItems() {
        CoreDataService.shared.resetAllRecords(in: K.CoreData.entityName) { result in
            switch result {
                case .success(_): break
                case .failure(_): break
            }
        }
    }

}
