//
//  FoodDetailViewControllerTests.swift
//  PizzaShopTests
//
//  Created by Arman Abkar on 10/30/21.
//

import XCTest
@testable import PizzaShop

class FoodDetailViewControllerTests: XCTestCase {
    
    let testFood = Food(name: "test", type: "test", price: 9.99, ingredients: "test", image: "test")
    
    override func tearDownWithError() throws {
        CoreDataService.shared.resetAllRecords(in: K.CoreData.entityName) { result in
            switch result {
                default: break
            }
        }
    }
    
    func test_CanInit() throws {
        _ = try makeSUT()
    }
    
    func test_configureUIElements() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        sut.configureUIElements()
        
        XCTAssertEqual(sut.foodNameLabel.text, testFood.name)
        XCTAssertEqual(sut.foodPriceLabel.text, "\(testFood.price)$")
        XCTAssertEqual(sut.foodIngredientsLabel.text, testFood.ingredients)
    }
    
    func test_addToCart() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        sut.addToCart()
        var testCart: [Cart]? = nil
        
        CoreDataService.shared.loadCartItems { result in
            switch result {
                case .success(let cart):
                    testCart = cart
                case .failure(_):
                    break
            }
        }
        
        XCTAssertEqual(testCart?[0].name, testFood.name)
        XCTAssertEqual(testCart?[0].price, testFood.price)
    }
    
    private func makeSUT() throws -> FoodDetailViewController {
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let vc: FoodDetailViewController = storyboard.instantiateViewController(withIdentifier: "FoodDetailViewController") as! FoodDetailViewController
        XCTAssertNotNil(vc)
        XCTAssertNotNil(vc.view)
        vc.food = testFood
        return vc
    }
    
}
