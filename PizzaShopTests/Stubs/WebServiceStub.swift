//
//  WebServiceStub.swift
//  PizzaShopTests
//
//  Created by Arman Abkar on 10/22/21.
//

import Foundation
@testable import PizzaShop

final class WebServiceStub: API {
    func start() async throws {}
    func getAllFoods(completion: @escaping (Result<[Food]?, NetworkError>) -> Void) {}
    func submitOrder(order: Order, completion: @escaping (Result<Int?, NetworkError>) -> Void) {}
    func submitReservation(reservation: Reservation, completion: @escaping (Result<Int?, NetworkError>) -> Void) {}
    func login(phone: User, completion: @escaping (Result<User?, NetworkError>) -> Void) {}
    func register(user: User, completion: @escaping (Result<User?, NetworkError>) -> Void) {}
}
