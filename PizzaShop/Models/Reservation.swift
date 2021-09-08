//
//  Reservation.swift
//  PizzaShop
//
//  Created by Arman Abkar on 9/7/21.
//

import Foundation

struct Reservation: Codable {
    let name: String
    let phone: String
    let tableSize: String
    let time: String
    let request: String?
}
