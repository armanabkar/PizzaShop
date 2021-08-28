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
    
    struct error {
        static let title = "Error"
        static let invalidFieldMessage = "Please enter a valid username/password."
    }
    
    struct URL {
        static let baseUrl = "https://pizzashop-server.herokuapp.com/"
        static let foodUrl = "https://pizzashop-server.herokuapp.com/api/v1/foods"
        static let newOrderUrl = "https://pizzashop-server.herokuapp.com/orders/add"
    }
    
}
