//
//  WebServiceStub.swift
//  PizzaShopTests
//
//  Created by Arman Abkar on 10/22/21.
//

import Foundation
@testable import PizzaShop

final class WebServiceStub: API {
    func start() async throws -> Int { return 200 }
    func getAllFoods() async throws -> [Food] {
        return [Food(name: "BBQ Chicken Pizza", type: "pizza", price: 14.99, ingredients: "Pizza crust, spicy barbecue sauce, chicken breast halves, fresh cilantro, pepperoncini peppers, red onion, Colby-Monterey Jack cheese", image: "images/bbq_chicken.jpg")]
    }
    func submitOrder(order: Order) async throws -> Int { return 200 }
    func submitReservation(reservation: Reservation) async throws -> Int { return 200 }
    func login(phone: User, completion: @escaping (Result<User?, NetworkError>) -> Void) {}
    func register(user: User, completion: @escaping (Result<User?, NetworkError>) -> Void) {}
}
