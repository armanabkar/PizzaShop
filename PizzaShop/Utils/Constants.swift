//
//  Constants.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/26/21.
//

import Foundation

struct K {
    
    struct Information {
        static let appName = "Pizza Shop"
        static let locationLatitude = 34.402341
        static let locationLongitude = -119.726045
        static let description1 = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, tempor incididunt ut magna aliqua. ut labore et dolore magna aliqua."
        static let description2 = "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. tempor incididunt magna magna et dolrore!"
        static let supportPhone = "(805) 681- 4200"
        static let address = "26 W Mission St , Santa Barbara, CA"
        static let copyright = "© 2022 Arman Abkar"
    }
    
    struct Identifiers {
        static let CFBundleShortVersionString = "CFBundleShortVersionString"
        static let CFBundleVersion = "CFBundleVersion"
        static let MenuCellNibName = "MenuCell"
        static let menuCellIdentifier = "ItemCell"
        static let orderCellIdentifier = "orderCell"
        static let menuSegue = "toMenuViewController"
        static let authSegue = "toAuthViewController"
        static let detailSegue = "toFoodDetailViewController"
    }
    
    struct CoreData {
        static let entityName = "Cart"
    }
    
    struct AR {
        static let pizzaModelLocation = "art.scnassets/Pizza.scn"
        static let omniLight = "omniLight"
        static let pizza = "pizza"
    }
    
    struct Fonts {
        static let pizzaHut = "PizzaHutFont"
    }
    
    struct Alert {
        static let title = "Error"
        static let confirmationTitle = "Are you sure?"
        static let cartTitle = "Cart"
        static let orderTitle = "Thank You"
        static let orderMessage = "Your order has been received. We will deliver it to you as soon as possible."
        static let notificationMessage = "Your order has been delivered. Thank you for choosing us."
        static let reservationMessage = "Your reservation has been made. We will wait for you in \(K.Information.appName)"
        static let invalidFieldMessage = "Please enter a valid name, phone, and address."
        static let userDoesNotExist = "User does not exist. Please register."
        static let userAlreadyExists = "User already exists. Try login or register with another number."
        static let fetchingError = "Error while fetching data. Please try again later."
        static let emptyCart = "The cart is empty. Please add some items."
        static let shake = "Be careful not to drop the phone! We know you can't wait to eat a pizza."
    }
    
    struct URL {
        static let baseUrl = "https://pizzashop-server.herokuapp.com"
        static let startUrl = "\(baseUrl)/start"
        static let foodUrl = "\(baseUrl)/api/v1/foods"
        static let newOrderUrl = "\(baseUrl)/api/v1/orders/add"
        static let newReservationUrl = "\(baseUrl)/api/v1/reservations/add"
        static let login = "\(baseUrl)/api/v1/users/login"
        static let register = "\(baseUrl)/api/v1/users/register"
    }
    
    struct Images {
        static let storeImage = "store"
        static let img1 = "Img1"
        static let img2 = "Img2"
        static let img3 = "Img3"
        static let img4 = "Img4"
        static let img5 = "Img5"
        static let img6 = "Img6"
    }
    
}
