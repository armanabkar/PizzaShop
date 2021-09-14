//
//  User.swift
//  PizzaShop
//
//  Created by Arman Abkar on 9/11/21.
//

import Foundation

struct User: Codable {
    let id: String?
    let name: String
    let phone: String
    let address: String
}
