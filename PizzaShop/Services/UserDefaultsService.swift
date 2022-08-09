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
    private let nameKey = "name"
    private let phoneKey = "phone"
    private let addressKey = "address"
    
    var name: String {
        UD.string(forKey: nameKey) ?? ""
    }
    
    var phone: String {
        UD.string(forKey: phoneKey) ?? ""
    }
    
    var address: String {
        UD.string(forKey: addressKey) ?? ""
    }

    /// Save the user's information to the User Defaults
    func saveUser(user: User) {
        UD.set(user.name, forKey: nameKey)
        UD.set(user.phone, forKey: phoneKey)
        UD.set(user.address, forKey: addressKey)
    }
    
    /// Remove the user's information from the User Defaults
    func removeUser() {
        UD.removeObject(forKey: nameKey)
        UD.removeObject(forKey: phoneKey)
        UD.removeObject(forKey: addressKey)
    }

}
