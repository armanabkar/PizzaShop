//
//  UserDefaultsService.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/30/21.
//

import UIKit

final class UserDefaultsService {
    
    private init() {}
    static let shared = UserDefaultsService()
    private let UD = UserDefaults.standard
    
    var name: String {
        UD.string(forKey: "name") ?? ""
    }
    
    var phone: String {
        UD.string(forKey: "phone") ?? ""
    }
    
    var address: String {
        UD.string(forKey: "address") ?? ""
    }
    
    var foods: [Food]? {
        if let foods = UD.value(forKey: "foods") as? Data {
            let decoder = JSONDecoder()
            if let cachedFoods = try? decoder.decode(Array.self, from: foods) as [Food] {
                return cachedFoods
            }
        }
        
        return []
    }
    
    /// Save the user's information to the User Defaults
    func saveUser(user: User) {
        UD.set(user.name, forKey: "name")
        UD.set(user.phone, forKey: "phone")
        UD.set(user.address, forKey: "address")
    }
    
    /// Remove the user's information from the User Defaults
    func removeUser() {
        UD.removeObject(forKey: "name")
        UD.removeObject(forKey: "phone")
        UD.removeObject(forKey: "address")
        UD.removeObject(forKey: "foods")
    }
    
    /// Save fetched foods as cache to User Defaults
    func saveFoodsToCache(foods: [Food]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(foods) {
            UD.set(encoded, forKey: "foods")
        }
    }
    
}
