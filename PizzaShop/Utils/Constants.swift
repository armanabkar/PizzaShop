//
//  Constants.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/26/21.
//

import Foundation

typealias getAllFoodsClosure = (Result<[Food]?, NetworkError>) -> Void
typealias submitRequestClosure = (Result<Int?, NetworkError>) -> Void
typealias getUserClosure = (Result<User?, NetworkError>) -> Void
typealias getCartItemsClosure = (Result<[Cart], CoreDataError>) -> Void
typealias CoreDataCRUDClosure = (Result<String, CoreDataError>) -> Void

struct K {
    
    static let appName = "Pizza Pizza"
    static let supportEmail = "support@pizzapizza.com"
    static let supportPhone = "8056814200"
    static let CFBundleShortVersionString = "CFBundleShortVersionString"
    static let CFBundleVersion = "CFBundleVersion"
    static let foodCellIdentifier = "foodCell"
    static let orderCellIdentifier = "orderCell"
    static let menuSegue = "toMenuViewController"
    static let authSegue = "toAuthViewController"
    static let detailSegue = "toFoodDetailViewController"
    
    struct CoreData {
        static let entityName = "Cart"
    }
    
    struct Alert {
        static let title = "Error"
        static let cartTitle = "Cart"
        static let orderTitle = "Thank You"
        static let orderMessage = "Your order has been received. We will deliver it to you as soon as possible."
        static let notificationMessage = "Your order has been delivered. Thank you for choosing us."
        static let reservationMessage = "Your reservation has been made. We will wait you!"
        static let invalidFieldMessage = "Please enter a valid name, phone and address."
        static let userDoesNotExist = "User Does not exist."
        static let userAlreadyExists = "User already exists. Try login with the number."
        static let emptyCart = "The cart is empty. Please add some items."
    }
    
    struct URL {
        static let baseUrl = "https://pizzashop-server.herokuapp.com"
        static let foodUrl = "\(baseUrl)/api/v1/foods"
        static let newOrderUrl = "\(baseUrl)/api/v1/orders/add"
        static let newReservationUrl = "\(baseUrl)/api/v1/reservations/add"
        static let login = "\(baseUrl)/api/v1/users/login"
        static let register = "\(baseUrl)/api/v1/users/register"
    }
    
}
