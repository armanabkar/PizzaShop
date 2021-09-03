//
//  Constants.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/26/21.
//

import Foundation

struct K {
    
    static let appName = "Pizza Pizza"
    static let foodCellIdentifier = "foodCell"
    static let orderCellIdentifier = "orderCell"
    static let menuSegue = "toMenuViewController"
    static let authSegue = "toAuthViewController"
    static let detailSegue = "toFoodDetailViewController"
    
    static let coreDataEntityName = "Cart"
    
    struct alert {
        static let title = "Error"
        static let cartTitle = "Cart"
        static let orderTitle = "Thank You"
        static let orderMessage = "Your order has been received. We will deliver it to you as soon as possible."
        static let invalidFieldMessage = "Please enter a valid name, phone and address."
        static let emptyCart = "The cart is empty. Please add some items."
    }
    
    struct URL {
        static let baseUrl = "https://pizzashop-server.herokuapp.com/"
        static let foodUrl = "https://pizzashop-server.herokuapp.com/api/v1/foods"
        static let newOrderUrl = "https://pizzashop-server.herokuapp.com/api/v1/orders/add"
    }
    
}
