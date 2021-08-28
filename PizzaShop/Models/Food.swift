//
//  Food.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/27/21.
//

import Foundation

struct Food: Decodable {
    let id: Int
    let name: String
    let type: String
    let price: Float
    let ingredients: String?
    let image: String
}
